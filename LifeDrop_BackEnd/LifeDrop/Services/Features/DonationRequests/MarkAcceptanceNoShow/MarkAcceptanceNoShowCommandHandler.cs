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

namespace Services.Features.DonationRequests.MarkAcceptanceNoShow;

/// <summary>
/// Handler for MarkAcceptanceNoShowCommand.
/// Allows hospital employee to mark a donor as no-show, freeing up the slot for other donors.
/// </summary>
public class MarkAcceptanceNoShowCommandHandler : IRequestHandler<MarkAcceptanceNoShowCommand, Result<MarkAcceptanceNoShowResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMediator _mediator;
    private readonly HybridCache _cache;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<MarkAcceptanceNoShowCommandHandler> _logger;

    public MarkAcceptanceNoShowCommandHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IMediator mediator,
        HybridCache cache,
        IOptions<DonationSettings> donationSettings,
        ILogger<MarkAcceptanceNoShowCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _mediator = mediator;
        _cache = cache;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<MarkAcceptanceNoShowResult>> Handle(MarkAcceptanceNoShowCommand request, CancellationToken cancellationToken)
    {
        // Ensure hospital ID is available
        if (!_currentUserService.HospitalId.HasValue)
        {
            _logger.LogWarning("No-show failed: no hospital context available.");
            return Result<MarkAcceptanceNoShowResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        var hospitalId = _currentUserService.HospitalId.Value;

        // 1. Fetch the acceptance with related entities
        var acceptance = await _unitOfWork.DonationAcceptances
            .Query()
            .Include(a => a.DonorProfile)
            .Include(a => a.DonationRequest)
                .ThenInclude(r => r.Hospital)
            .Include(a => a.DonationRequest)
                .ThenInclude(r => r.RequestDistricts)
                    .ThenInclude(rd => rd.District)
                        .ThenInclude(d => d.Governorate)
            .FirstOrDefaultAsync(a => a.Id == request.AcceptanceId, cancellationToken);

        if (acceptance == null)
        {
            _logger.LogWarning("No-show failed: acceptance {AcceptanceId} not found.", request.AcceptanceId);
            return Result<MarkAcceptanceNoShowResult>.Failure(DonationErrors.AcceptanceNotFound);
        }

        // 2. Verify the request belongs to this hospital
        if (acceptance.DonationRequest.HospitalId != hospitalId)
        {
            _logger.LogWarning("No-show failed: hospital {HospitalId} not authorized for acceptance {AcceptanceId}.", hospitalId, request.AcceptanceId);
            return Result<MarkAcceptanceNoShowResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        // 3. Verify acceptance is in Accepted state
        if (acceptance.Status != AcceptanceStatus.Accepted)
        {
            _logger.LogWarning("No-show failed: acceptance {AcceptanceId} in invalid state '{Status}'.", request.AcceptanceId, acceptance.Status);
            return Result<MarkAcceptanceNoShowResult>.Failure(DonationErrors.AcceptanceNotAccepted);
        }

        var donationRequest = acceptance.DonationRequest;

        // 4. Verify request is still active
        if (donationRequest.Status != RequestStatus.Active)
        {
            _logger.LogWarning("No-show failed: request is not active for acceptance {AcceptanceId}.", request.AcceptanceId);
            return Result<MarkAcceptanceNoShowResult>.Failure(DonationErrors.RequestNotActive);
        }

        // 5. Execute business logic: Mark as no-show
        var noShowResult = acceptance.MarkAsNoShow();
        if (!noShowResult.IsSuccess)
        {
            return Result<MarkAcceptanceNoShowResult>.Failure(noShowResult.Error!);
        }

        // 6. Decrement active acceptances on the request to free up the slot
        var decrementResult = donationRequest.DecrementActiveAcceptances();
        if (!decrementResult.IsSuccess)
        {
            return Result<MarkAcceptanceNoShowResult>.Failure(decrementResult.Error!);
        }

        // 7. Apply reliability penalty to donor (PRD 3.7 - No-Show Penalty)
        var donorProfile = acceptance.DonorProfile;

        if (donorProfile != null)
        {
            donorProfile.ReliabilityScore = Math.Max(
                0, 
                donorProfile.ReliabilityScore - _donationSettings.ReliabilityPenaltyPerNoShow);
        }

        // 8.1 Raise hospital SignalR event (Outbox Pattern)
        donationRequest.AddDomainEvent(new AcceptanceNoShowEvent(
            donationRequest.Id,
            acceptance.Id,
            hospitalId,
            donorProfile?.UserId ?? Guid.Empty,
            donationRequest.CurrentActiveAcceptances,
            donationRequest.TargetQuota));

        // 8.2 Prepare the notification events — one per distinct governorate (Outbox Pattern)
        var targetGovernorates = donationRequest.RequestDistricts
            .Where(rd => rd.District?.Governorate != null)
            .GroupBy(rd => rd.District!.GovernorateId)
            .Select(g => g.First().District!)
            .ToList();

        foreach (var district in targetGovernorates)
        {
            donationRequest.AddDomainEvent(new DonationSlotReopenedEvent(
                donationRequest.Id,
                district.GovernorateId,
                district.Governorate!.Name,
                donationRequest.BloodType,
                donationRequest.Hospital?.Name ?? "Hospital"));
        }

        // 8.3 Save changes with concurrency handling (Includes Outbox Message)
        try
        {
            await _unitOfWork.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            _logger.LogError("Concurrency conflict while marking acceptance {AcceptanceId} as no-show.", request.AcceptanceId);
            return Result<MarkAcceptanceNoShowResult>.Failure(DonationErrors.ConcurrencyConflict);
        }

        var cacheTasks = new List<Task>
        {
            _cache.RemoveByTagAsync($"dashboard_hospital_{hospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_{hospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_requests_{hospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"request_{donationRequest.Id}", cancellationToken).AsTask()
        };

        if (donorProfile != null)
        {
            cacheTasks.Add(_cache.RemoveByTagAsync("leaderboard", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"donor_{donorProfile.UserId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"donor_feed_{donorProfile.UserId}", cancellationToken).AsTask());
        }

        await Task.WhenAll(cacheTasks);

        _logger.LogInformation("Acceptance {AcceptanceId} marked as no-show. Reliability penalty applied to donor.", request.AcceptanceId);

        return Result<MarkAcceptanceNoShowResult>.Success(
            new MarkAcceptanceNoShowResult(acceptance.Id, donationRequest.Id, acceptance.Status.ToString())
        );
    }
}