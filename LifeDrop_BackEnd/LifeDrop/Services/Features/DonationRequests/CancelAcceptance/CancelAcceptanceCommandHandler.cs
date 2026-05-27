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

namespace Services.Features.DonationRequests.CancelAcceptance;

/// <summary>
/// Handler for CancelAcceptanceCommand.
/// Allows a donor to cancel their acceptance of a donation request.
/// Decrements the request's active acceptances to free up the slot.
/// </summary>
public class CancelAcceptanceCommandHandler : IRequestHandler<CancelAcceptanceCommand, Result<CancelAcceptanceResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMediator _mediator;
    private readonly HybridCache _cache;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<CancelAcceptanceCommandHandler> _logger;

    public CancelAcceptanceCommandHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IMediator mediator,
        HybridCache cache,
        IOptions<DonationSettings> donationSettings,
        ILogger<CancelAcceptanceCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _mediator = mediator;
        _cache = cache;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<CancelAcceptanceResult>> Handle(CancelAcceptanceCommand request, CancellationToken cancellationToken)
    {
        // Use UserId from JWT token for security
        var donorUserId = _currentUserService.UserId;

        // 1. Fetch ONLY the specific acceptance for this donor and request, including necessary relations
        var acceptance = await _unitOfWork.DonationAcceptances
            .Query()
            .Include(a => a.DonorProfile)
            .Include(a => a.DonationRequest)
                .ThenInclude(r => r.Hospital)
            .Include(a => a.DonationRequest)
                .ThenInclude(r => r.RequestDistricts)
                    .ThenInclude(rd => rd.District)
                        .ThenInclude(d => d.Governorate)
            .FirstOrDefaultAsync(a => a.DonationRequestId == request.RequestId && 
                                      a.DonorProfile!.UserId == donorUserId && 
                                      a.Status == AcceptanceStatus.Accepted, cancellationToken);

        if (acceptance == null)
        {
            _logger.LogWarning("Cancel acceptance failed: active acceptance not found for donor {UserId} on request {RequestId}.", donorUserId, request.RequestId);
            return Result<CancelAcceptanceResult>.Failure(DonationErrors.AcceptanceNotFound);
        }

        var donationRequest = acceptance.DonationRequest;

        // 2. Verify request is still active
        if (donationRequest.Status != RequestStatus.Active)
        {
            _logger.LogWarning("Cancel acceptance failed: request {RequestId} is not active.", request.RequestId);
            return Result<CancelAcceptanceResult>.Failure(DonationErrors.RequestNotActive);
        }

        // 3. Validate cancellation reason exists and is active
        var cancellationReason = await _unitOfWork.CancellationReasons
            .Query()
            .FirstOrDefaultAsync(r => r.Id == request.CancellationReasonId && r.IsActive, cancellationToken);

        if (cancellationReason == null)
        {
            _logger.LogWarning("Cancel acceptance failed: invalid cancellation reason {ReasonId}.", request.CancellationReasonId);
            return Result<CancelAcceptanceResult>.Failure(DonationErrors.InvalidCancellationReason);
        }

        // 4. Execute business logic: Cancel the acceptance (with reason and note)
        var cancelResult = acceptance.CancelByDonor(request.CancellationReasonId, request.Note);
        if (!cancelResult.IsSuccess)
        {
            return Result<CancelAcceptanceResult>.Failure(cancelResult.Error!);
        }

        // 5. Decrement active acceptances on the request to free up the slot
        var decrementResult = donationRequest.DecrementActiveAcceptances();
        if (!decrementResult.IsSuccess)
        {
            return Result<CancelAcceptanceResult>.Failure(decrementResult.Error!);
        }

        // 5.1 Apply reliability penalty to donor (PRD 3.6 - Cancellation Penalty)
        // We already have the DonorProfile from the inclusion above, no need to query again!
        if (acceptance.DonorProfile != null)
        {
            acceptance.DonorProfile.ReliabilityScore = Math.Max(
                0, 
                acceptance.DonorProfile.ReliabilityScore - _donationSettings.ReliabilityPenaltyPerCancellation);
        }

        // 6.2 Prepare the notification events — one per distinct governorate (Outbox Pattern)
        var targetGovernorates = donationRequest.RequestDistricts
            .Where(rd => rd.District?.Governorate != null)
            .GroupBy(rd => rd.District!.GovernorateId)
            .Select(g => g.First().District!)
            .ToList();

        foreach (var district in targetGovernorates)
        {
            donationRequest.AddDomainEvent(new DonationSlotReopenedEvent(
                request.RequestId,
                district.GovernorateId,
                district.Governorate!.Name,
                donationRequest.BloodType,
                donationRequest.Hospital?.Name ?? "Hospital"));
        }

        // Notify hospital staff via SignalR (through Outbox)
        donationRequest.AddDomainEvent(new AcceptanceCancelledByDonorEvent(
            donationRequest.Id,
            acceptance.Id,
            donationRequest.HospitalId,
            donorUserId,
            donationRequest.CurrentActiveAcceptances,
            donationRequest.TargetQuota));

        // 6.3 Save changes with concurrency handling (Includes Outbox Message)
        try
        {
            await _unitOfWork.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            _logger.LogError("Concurrency conflict while canceling acceptance on request {RequestId}.", request.RequestId);
            return Result<CancelAcceptanceResult>.Failure(DonationErrors.ConcurrencyConflict);
        }

        // 6.4 Invalidate caches in parallel
        await Task.WhenAll(
            _cache.RemoveByTagAsync("leaderboard", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"donor_{donorUserId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"donor_feed_{donorUserId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_requests_{donationRequest.HospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"request_{request.RequestId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"communication_hospital_{donationRequest.HospitalId}", cancellationToken).AsTask()
        );

        _logger.LogInformation("Donor {UserId} cancelled acceptance on request {RequestId}. Reliability penalty applied.", donorUserId, request.RequestId);

        return Result<CancelAcceptanceResult>.Success(
            new CancelAcceptanceResult(donationRequest.Id, acceptance.Status.ToString())
        );
    }
}