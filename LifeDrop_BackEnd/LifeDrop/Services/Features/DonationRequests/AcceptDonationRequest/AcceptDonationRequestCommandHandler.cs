using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using Core.Helpers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Configuration;
using Microsoft.Extensions.Logging;
using RequestStatus = Core.Enums.RequestStatus;
using AcceptanceStatus = Core.Enums.AcceptanceStatus;
using UrgencyLevel = Core.Enums.UrgencyLevel;

using Microsoft.Extensions.Caching.Hybrid;
using Services.Features.DonationRequests.Events;

namespace Services.Features.DonationRequests.AcceptDonationRequest;

public class AcceptDonationRequestCommandHandler : IRequestHandler<AcceptDonationRequestCommand, Result<AcceptDonationRequestResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly DonationSettings _donationSettings;
    private readonly HybridCache _cache;
    private readonly ILogger<AcceptDonationRequestCommandHandler> _logger;

    public AcceptDonationRequestCommandHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IOptions<DonationSettings> donationSettings,
        HybridCache cache,
        ILogger<AcceptDonationRequestCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _donationSettings = donationSettings.Value;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<AcceptDonationRequestResult>> Handle(AcceptDonationRequestCommand request, CancellationToken cancellationToken)
    {
        // Use UserId from JWT token for security (instead of from request)
        var donorUserId = _currentUserService.UserId;

        // 1. Fetch the donation request
        var donationRequest = await _unitOfWork.DonationRequests
            .Query()
            .FirstOrDefaultAsync(r => r.Id == request.DonationRequestId, cancellationToken);

        if (donationRequest == null)
        {
            _logger.LogWarning("Accept failed: donation request {RequestId} not found.", request.DonationRequestId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.RequestNotFound);
        }

        // 2. Check if request is still active
        if (donationRequest.Status != RequestStatus.Active)
        {
            _logger.LogWarning("Accept failed: request {RequestId} is no longer active.", request.DonationRequestId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.RequestNotActive);
        }

        // 3. Get donor profile
        var donorProfile = await _unitOfWork.DonorProfiles
            .Query()
            .Include(d => d.User)
            .FirstOrDefaultAsync(d => d.UserId == donorUserId, cancellationToken);

        if (donorProfile == null)
        {
            _logger.LogWarning("Accept failed: donor profile not found for user {UserId}.", donorUserId);
            return Result<AcceptDonationRequestResult>.Failure(DonorErrors.NotFound);
        }

        // 3.1 Ensure donor has a blood type set
        if (!donorProfile.BloodType.HasValue)
        {
            _logger.LogWarning("Accept failed: donor {UserId} has no blood type set.", donorUserId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.BloodTypeNotSet);
        }

        // 4. Check donor's acceptance status (Single Commitment & Duplicate Acceptance Rule)
        // Optimized: Combined two database checks into one round-trip
        var activeAcceptance = await _unitOfWork.DonationAcceptances
            .Query()
            .Where(a => a.DonorProfileId == donorProfile.Id && a.Status == AcceptanceStatus.Accepted)
            .Select(a => new { a.DonationRequestId })
            .FirstOrDefaultAsync(cancellationToken);

        if (activeAcceptance != null)
        {
            if (activeAcceptance.DonationRequestId == request.DonationRequestId)
            {
                _logger.LogWarning("Accept failed: donor {UserId} already accepted request {RequestId}.", donorUserId, request.DonationRequestId);
                return Result<AcceptDonationRequestResult>.Failure(DonationErrors.AlreadyAccepted);
            }

            _logger.LogWarning("Accept failed: donor {UserId} has an existing active commitment.", donorUserId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.HasActiveCommitment);
        }

        // 5. Check blood type compatibility (using compatibility helper to allow universal donors like O- to donate to compatible recipients)
        if (!donorProfile.BloodType.HasValue || !donorProfile.BloodType.Value.CanDonateTo(donationRequest.BloodType))
        {
            _logger.LogWarning("Accept failed: donor {UserId} blood type incompatible with request {RequestId}.", donorUserId, request.DonationRequestId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.IncompatibleBloodType);
        }

        // 6. Check if donor is available
        if (!donorProfile.IsAvailable)
        {
            _logger.LogWarning("Accept failed: donor {UserId} availability is off.", donorUserId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.DonorNotAvailable);
        }

        // 6.2 Check cooldown period (PRD 3.8)
        if (donorProfile.LastDonationDate.HasValue)
        {
            var daysSinceLastDonation = (DateTimeOffset.UtcNow - donorProfile.LastDonationDate.Value).TotalDays;
            if (daysSinceLastDonation < _donationSettings.CooldownDays)
            {
                _logger.LogWarning("Accept failed: donor {UserId} is in cooldown period.", donorUserId);
                var nextEligibleDate = donorProfile.LastDonationDate.Value.AddDays(_donationSettings.CooldownDays);
                return Result<AcceptDonationRequestResult>.Failure(DonationErrors.InCooldownAt(nextEligibleDate));
            }
        }

        // 6.3 PRD 3.5: Critical requests require medical verification
        if (donationRequest.Urgency == UrgencyLevel.Critical && !donorProfile.IsMedicallyVerified)
        {
            _logger.LogWarning("Accept failed: donor {UserId} not medically verified for critical request {RequestId}.", donorUserId, request.DonationRequestId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.CriticalRequiresVerification);
        }

        // 7. Increment active acceptances (Business Logic)
        var incrementResult = donationRequest.IncrementActiveAcceptances();
        if (!incrementResult.IsSuccess)
        {
            _logger.LogWarning("Accept failed: request {RequestId} quota is full.", request.DonationRequestId);
            return Result<AcceptDonationRequestResult>.Failure(incrementResult.Error!);
        }

        // 8. Create acceptance record
        var acceptance = new DonationAcceptance
        {
            DonationRequestId = donationRequest.Id,
            DonorProfileId = donorProfile.Id,
            Status = AcceptanceStatus.Accepted,
            AcceptedAt = DateTime.UtcNow
        };

        await _unitOfWork.DonationAcceptances.AddAsync(acceptance);

        // Notify hospital staff via SignalR (through Outbox)
        var donorFullName = donorProfile.User != null
            ? $"{donorProfile.User.FirstName} {donorProfile.User.LastName}"
            : "A donor";
        donationRequest.AddDomainEvent(new DonationAcceptedByDonorEvent(
            donationRequest.Id,
            acceptance.Id,
            donationRequest.HospitalId,
            donorUserId,
            donorFullName,
            donationRequest.BloodType,
            acceptance.AcceptedAt,
            donationRequest.Status,
            donationRequest.CurrentActiveAcceptances,
            donationRequest.TargetQuota));

        // 9. Save with Optimistic Concurrency handling
        try
        {
            await _unitOfWork.SaveChangesAsync(cancellationToken);
            
            // Run all cache invalidations in parallel. Accepting a request does not affect
            // the donor's profile/cooldown/gamification — only feed, home screen, and request detail.
            await Task.WhenAll(
                _cache.RemoveByTagAsync($"communication_hospital_{donationRequest.HospitalId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"hospital_requests_{donationRequest.HospitalId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"request_{donationRequest.Id}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"donor_feed_{donorUserId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"donor_home_{donorUserId}", cancellationToken).AsTask()
            );
        }
        catch (DbUpdateConcurrencyException)
        {
            _logger.LogError("Concurrency conflict while accepting request {RequestId} by donor {UserId}.", request.DonationRequestId, donorUserId);
            return Result<AcceptDonationRequestResult>.Failure(DonationErrors.ConcurrencyConflict);
        }

        _logger.LogInformation("Donor {UserId} accepted donation request {RequestId}. Acceptance ID: {AcceptanceId}.", donorUserId, request.DonationRequestId, acceptance.Id);

        return Result<AcceptDonationRequestResult>.Success(
            new AcceptDonationRequestResult(acceptance.Id, donationRequest.Id, acceptance.Status.ToString())
        );
    }
}
