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
using RequestStatus = Core.Enums.RequestStatus;
using AcceptanceStatus = Core.Enums.AcceptanceStatus;
using Microsoft.Extensions.Caching.Hybrid;

namespace Services.Features.DonationRequests.FulfillAcceptance;

/// <summary>
/// Handler for FulfillAcceptanceCommand.
/// Marks a donor's acceptance as fulfilled and increments the request's fulfilled count.
/// </summary>
public class FulfillAcceptanceCommandHandler : IRequestHandler<FulfillAcceptanceCommand, Result<FulfillAcceptanceResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly DonationSettings _donationSettings;
    private readonly HybridCache _cache;
    private readonly ILogger<FulfillAcceptanceCommandHandler> _logger;

    public FulfillAcceptanceCommandHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IOptions<DonationSettings> donationSettings,
        HybridCache cache,
        ILogger<FulfillAcceptanceCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _donationSettings = donationSettings.Value;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<FulfillAcceptanceResult>> Handle(FulfillAcceptanceCommand request, CancellationToken cancellationToken)
    {
        // Ensure hospital ID is available
        if (!_currentUserService.HospitalId.HasValue)
        {
            _logger.LogWarning("Fulfill failed: no hospital context available.");
            return Result<FulfillAcceptanceResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        var hospitalId = _currentUserService.HospitalId.Value;

        // 1. Fetch the acceptance with related entities
        var acceptance = await _unitOfWork.DonationAcceptances
            .Query()
            .Include(a => a.DonationRequest)
            .Include(a => a.DonorProfile)
            .FirstOrDefaultAsync(a => a.Id == request.AcceptanceId, cancellationToken);

        if (acceptance == null)
        {
            _logger.LogWarning("Fulfill failed: acceptance {AcceptanceId} not found.", request.AcceptanceId);
            return Result<FulfillAcceptanceResult>.Failure(DonationErrors.AcceptanceNotFound);
        }

        // 2. Verify the request belongs to this hospital
        if (acceptance.DonationRequest.HospitalId != hospitalId)
        {
            _logger.LogWarning("Fulfill failed: hospital {HospitalId} not authorized for acceptance {AcceptanceId}.", hospitalId, request.AcceptanceId);
            return Result<FulfillAcceptanceResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        // 3. Verify acceptance is in Accepted state
        if (acceptance.Status != AcceptanceStatus.Accepted)
        {
            _logger.LogWarning("Fulfill failed: acceptance {AcceptanceId} in invalid state '{Status}'.", request.AcceptanceId, acceptance.Status);
            return Result<FulfillAcceptanceResult>.Failure(DonationErrors.AcceptanceNotAccepted);
        }

        var donationRequest = acceptance.DonationRequest;

        // 4. Verify request is still active
        if (donationRequest.Status != RequestStatus.Active)
        {
            _logger.LogWarning("Fulfill failed: request {RequestId} is not active.", donationRequest.Id);
            return Result<FulfillAcceptanceResult>.Failure(DonationErrors.RequestNotActive);
        }

        // 5. Execute business logic: Fulfill the acceptance
        var fulfillResult = acceptance.Fulfill();
        if (!fulfillResult.IsSuccess)
        {
            return Result<FulfillAcceptanceResult>.Failure(fulfillResult.Error!);
        }

        // 6. Increment fulfilled count on the request
        var incrementResult = donationRequest.IncrementFulfilledAcceptances();
        if (!incrementResult.IsSuccess)
        {
            return Result<FulfillAcceptanceResult>.Failure(incrementResult.Error!);
        }

        // 6.1 Get donor profile and update donation date + add points (PRD 3.8 & 3.9)
        var donorProfile = acceptance.DonorProfile;

        if (donorProfile != null)
        {
            donorProfile.LastDonationDate = DateTimeOffset.UtcNow;
            donorProfile.GamificationPoints += _donationSettings.PointsPerDonation;

            var pointTransaction = new PointTransaction
            {
                DonorProfileId = donorProfile.Id,
                Points = _donationSettings.PointsPerDonation,
                ActionType = "DonationFulfillment",
                Description = $"Blood donation fulfilled for request {donationRequest.Id}",
                ReferenceId = donationRequest.Id
            };
            
            await _unitOfWork.PointTransactions.AddAsync(pointTransaction);
        }

        // 6.2 Raise domain event for hospital SignalR notifications (Outbox Pattern)
        donationRequest.AddDomainEvent(new AcceptanceFulfilledEvent(
            donationRequest.Id,
            acceptance.Id,
            hospitalId,
            donorProfile?.UserId ?? Guid.Empty,
            donationRequest.Status,
            donationRequest.CurrentFulfilledAcceptances,
            donationRequest.TargetQuota));

        // 7. Save changes
        try
        {
            await _unitOfWork.SaveChangesAsync(cancellationToken);
            
            var cacheTasks = new List<Task>();
            
            // Invalidate leaderboard cache since points changed
            if (donorProfile != null)
            {
                cacheTasks.Add(_cache.RemoveByTagAsync("leaderboard", cancellationToken).AsTask());
                cacheTasks.Add(_cache.RemoveByTagAsync($"donor_{donorProfile.UserId}", cancellationToken).AsTask());
                cacheTasks.Add(_cache.RemoveByTagAsync($"donor_gamification_{donorProfile.UserId}", cancellationToken).AsTask());
            }

            // Invalidate hospital dashboard and analytics
            cacheTasks.Add(_cache.RemoveByTagAsync($"dashboard_hospital_{hospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"hospital_{hospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"hospital_requests_{hospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"communication_hospital_{hospitalId}", cancellationToken).AsTask());
            cacheTasks.Add(_cache.RemoveByTagAsync($"request_{donationRequest.Id}", cancellationToken).AsTask());
            
            // Invalidate donor feed as they might see different requests or their status changed
            if (donorProfile != null)
            {
                cacheTasks.Add(_cache.RemoveByTagAsync($"donor_feed_{donorProfile.UserId}", cancellationToken).AsTask());
            }
            
            // Invalidate global operations for admin
            cacheTasks.Add(_cache.RemoveByTagAsync("admin_stats", cancellationToken).AsTask());

            await Task.WhenAll(cacheTasks);
        }
        catch (DbUpdateConcurrencyException)
        {
            _logger.LogError("Concurrency conflict while fulfilling acceptance {AcceptanceId}.", request.AcceptanceId);
            return Result<FulfillAcceptanceResult>.Failure(DonationErrors.ConcurrencyConflict);
        }

        // 8. Return success with info about whether entire request is now fulfilled
        var requestFulfilled = donationRequest.Status == RequestStatus.Fulfilled;

        _logger.LogInformation("Acceptance {AcceptanceId} fulfilled for request {RequestId}. Points awarded: {Points}. Request fully fulfilled: {IsFullyFulfilled}.",
            request.AcceptanceId, donationRequest.Id, _donationSettings.PointsPerDonation, requestFulfilled);

        return Result<FulfillAcceptanceResult>.Success(
            new FulfillAcceptanceResult(
                acceptance.Id,
                donationRequest.Id,
                acceptance.Status.ToString(),
                requestFulfilled
            )
        );
    }
}