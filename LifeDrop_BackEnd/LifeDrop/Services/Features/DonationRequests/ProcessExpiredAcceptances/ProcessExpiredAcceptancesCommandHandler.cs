using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Features.DonationRequests.Events;
using Services.Interfaces;
using Shared.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Caching.Hybrid;
using AcceptanceStatus = Core.Enums.AcceptanceStatus;
using RequestStatus = Core.Enums.RequestStatus;

namespace Services.Features.DonationRequests.ProcessExpiredAcceptances;

/// <summary>
/// Handler for processing expired acceptances.
/// Finds all accepted donations that have passed the timeout threshold and marks them as NoShow,
/// decrements the request quota, and applies reliability penalty to the donor.
/// </summary>
public class ProcessExpiredAcceptancesCommandHandler : IRequestHandler<ProcessExpiredAcceptancesCommand, Result<ProcessExpiredAcceptancesResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IMediator _mediator;
    private readonly HybridCache _cache;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<ProcessExpiredAcceptancesCommandHandler> _logger;

    public ProcessExpiredAcceptancesCommandHandler(
        IUnitOfWork unitOfWork,
        IMediator mediator,
        HybridCache cache,
        IOptions<DonationSettings> donationSettings,
        ILogger<ProcessExpiredAcceptancesCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _mediator = mediator;
        _cache = cache;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<ProcessExpiredAcceptancesResult>> Handle(
        ProcessExpiredAcceptancesCommand request,
        CancellationToken cancellationToken)
    {
        // Calculate the cutoff time (e.g., 2 hours ago)
        var cutoffTime = DateTimeOffset.UtcNow.AddHours(-_donationSettings.AcceptanceTimeoutHours);

        // Find all accepted acceptances that have expired
        var expiredAcceptances = await _unitOfWork.DonationAcceptances
            .Query()
            .AsTracking()
            .Where(a => a.Status == AcceptanceStatus.Accepted && a.AcceptedAt < cutoffTime)
            .ToListAsync(cancellationToken);

        if (expiredAcceptances.Count == 0)
        {
            _logger.LogInformation("No expired acceptances found to process.");
            return Result<ProcessExpiredAcceptancesResult>.Success(
                new ProcessExpiredAcceptancesResult
                {
                    ProcessedCount = 0,
                    PenalizedDonorCount = 0,
                    ReactivatedRequestCount = 0
                });
        }

        // Collect all donor profile IDs and request IDs for batch fetching
        var donorProfileIds = expiredAcceptances
            .Select(a => a.DonorProfileId)
            .Distinct()
            .ToList();

        var requestIds = expiredAcceptances
            .Select(a => a.DonationRequestId)
            .Distinct()
            .ToList();

        // Batch fetch all donor profiles in a single query (avoid N+1)
        var donorProfilesById = (await _unitOfWork.DonorProfiles
            .Query()
            .AsTracking()
            .Where(d => donorProfileIds.Contains(d.Id))
            .ToDictionaryAsync(d => d.Id, cancellationToken));

        // Tracked query for mutation (scalar columns only — no navigation includes needed).
        var donationRequestsById = await _unitOfWork.DonationRequests
            .Query()
            .AsTracking()
            .Where(r => requestIds.Contains(r.Id))
            .ToDictionaryAsync(r => r.Id, cancellationToken);

        // No-tracking projection for event data only — avoids loading full District/Governorate/Hospital entities.
        var requestEventData = await _unitOfWork.DonationRequests
            .Query()
            .AsNoTracking()
            .Where(r => requestIds.Contains(r.Id))
            .Select(r => new
            {
                r.Id,
                r.BloodType,
                HospitalName = r.Hospital.Name,
                Governorates = r.RequestDistricts
                    .Select(rd => new { rd.District!.GovernorateId, GovernorateName = rd.District.Governorate!.Name })
                    .ToList()
            })
            .ToDictionaryAsync(x => x.Id, cancellationToken);

        var penalizedDonorCount = 0;
        // Track (requestId, governorateId) pairs to avoid duplicate events per request+governorate
        var firedSlotEvents = new HashSet<(Guid RequestId, Guid GovernorateId)>();
        var reactivatedRequestIds = new HashSet<Guid>();

        // Process each expired acceptance using in-memory lookups
        foreach (var acceptance in expiredAcceptances)
        {
            // 1. Mark acceptance as NoShow
            acceptance.Status = AcceptanceStatus.NoShow;

            // 2. Apply penalty to donor profile using batch-fetched data
            if (donorProfilesById.TryGetValue(acceptance.DonorProfileId, out var donorProfile))
            {
                donorProfile.ReliabilityScore = Math.Max(
                    0,
                    donorProfile.ReliabilityScore - _donationSettings.ReliabilityPenaltyPerNoShow);
                penalizedDonorCount++;
            }

            // 3. Decrement active acceptances on the request and prepare notification using batch-fetched data
            if (donationRequestsById.TryGetValue(acceptance.DonationRequestId, out var donationRequest))
            {
                if (donationRequest.Status == RequestStatus.Active)
                {
                    donationRequest.CurrentActiveAcceptances = Math.Max(
                        0,
                        donationRequest.CurrentActiveAcceptances - 1);
                    
                    // Fire one slot-reopened event per distinct governorate (avoid duplicates in this batch).
                    // Governorate data comes from the no-tracking projection — no navigation props on the tracked entity.
                    reactivatedRequestIds.Add(donationRequest.Id);
                    if (requestEventData.TryGetValue(donationRequest.Id, out var eventData))
                    {
                        foreach (var gov in eventData.Governorates)
                        {
                            if (firedSlotEvents.Add((donationRequest.Id, gov.GovernorateId)))
                            {
                                donationRequest.AddDomainEvent(new DonationSlotReopenedEvent(
                                    donationRequest.Id,
                                    gov.GovernorateId,
                                    gov.GovernorateName,
                                    eventData.BloodType,
                                    eventData.HospitalName));
                            }
                        }
                    }
                }
            }
        }

        // Save all changes in a single transaction
        try
        {
            await _unitOfWork.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            _logger.LogError("Concurrency conflict while processing expired acceptances.");
            return Result<ProcessExpiredAcceptancesResult>.Failure(DonationErrors.ConcurrencyConflict);
        }

        // 6.1 Invalidate caches since reliability scores and request quotas changed
        var cacheTasks = new List<Task>
        {
            _cache.RemoveByTagAsync("leaderboard", cancellationToken).AsTask()
        };

        foreach (var profile in donorProfilesById.Values)
        {
            cacheTasks.Add(_cache.RemoveByTagAsync($"donor_{profile.UserId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"donor_feed_{profile.UserId}", cancellationToken).AsTask());
        }

        foreach (var requestItem in donationRequestsById.Values)
        {
            cacheTasks.Add(_cache.RemoveByTagAsync($"hospital_requests_{requestItem.HospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"dashboard_hospital_{requestItem.HospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"hospital_{requestItem.HospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"request_{requestItem.Id}", cancellationToken).AsTask());
        }

        await Task.WhenAll(cacheTasks);


        _logger.LogInformation("Processed {ProcessedCount} expired acceptances. Penalized {PenalizedCount} donors. Reactivated {ReactivatedCount} request slots.",
            expiredAcceptances.Count, penalizedDonorCount, reactivatedRequestIds.Count);

        return Result<ProcessExpiredAcceptancesResult>.Success(
            new ProcessExpiredAcceptancesResult
            {
                ProcessedCount = expiredAcceptances.Count,
                PenalizedDonorCount = penalizedDonorCount,
                ReactivatedRequestCount = reactivatedRequestIds.Count
            });
    }
}