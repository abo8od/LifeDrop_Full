using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

using Microsoft.Extensions.Caching.Hybrid;

namespace Services.Features.DonationRequests.CancelRequest;

/// <summary>
/// Handler for CancelRequestCommand.
/// Allows hospital employee to cancel an active donation request.
/// </summary>
public class CancelRequestCommandHandler : IRequestHandler<CancelRequestCommand, Result<CancelRequestResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly HybridCache _cache;
    private readonly ILogger<CancelRequestCommandHandler> _logger;

    public CancelRequestCommandHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, HybridCache cache, ILogger<CancelRequestCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<CancelRequestResult>> Handle(CancelRequestCommand request, CancellationToken cancellationToken)
    {
        // Ensure hospital ID is available
        if (!_currentUserService.HospitalId.HasValue)
        {
            _logger.LogWarning("Cancel request failed: no hospital context available.");
            return Result<CancelRequestResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        var hospitalId = _currentUserService.HospitalId.Value;

        // 1. Fetch the donation request
        var donationRequest = await _unitOfWork.DonationRequests
            .Query()
            .Include(r => r.Acceptances)
                .ThenInclude(a => a.DonorProfile)
            .FirstOrDefaultAsync(r => r.Id == request.RequestId, cancellationToken);

        if (donationRequest == null)
        {
            _logger.LogWarning("Cancel request failed: request {RequestId} not found.", request.RequestId);
            return Result<CancelRequestResult>.Failure(DonationErrors.RequestNotFound);
        }

        // 2. Verify the request belongs to this hospital
        if (donationRequest.HospitalId != hospitalId)
        {
            _logger.LogWarning("Cancel request failed: hospital {HospitalId} not authorized for request {RequestId}.", hospitalId, request.RequestId);
            return Result<CancelRequestResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        // 3. Verify request is still active
        if (donationRequest.Status != RequestStatus.Active)
        {
            _logger.LogWarning("Cancel request failed: request {RequestId} is not active.", request.RequestId);
            return Result<CancelRequestResult>.Failure(DonationErrors.RequestNotActive);
        }

        // 4. Execute business logic: Cancel the request
        var cancelResult = donationRequest.Cancel();
        if (!cancelResult.IsSuccess)
        {
            return Result<CancelRequestResult>.Failure(cancelResult.Error!);
        }

        // 4.1 Cancel all active acceptances (so donors know it was cancelled)
        var affectedDonorUserIds = new List<Guid>();
        foreach (var acceptance in donationRequest.Acceptances.Where(a => a.Status == AcceptanceStatus.Accepted))
        {
            acceptance.CancelByHospital();
            if (acceptance.DonorProfile != null)
            {
                affectedDonorUserIds.Add(acceptance.DonorProfile.UserId);
            }
        }

        // 5. Save changes
        try
        {
            await _unitOfWork.SaveChangesAsync(cancellationToken);

            var cacheTasks = new List<Task>
            {
                // Invalidate hospital dashboard and admin stats
                _cache.RemoveByTagAsync($"dashboard_hospital_{hospitalId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"hospital_{hospitalId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"hospital_requests_{hospitalId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync($"request_{request.RequestId}", cancellationToken).AsTask(),
                _cache.RemoveByTagAsync("admin_stats", cancellationToken).AsTask()
            };

            // Invalidate donor caches
            foreach (var userId in affectedDonorUserIds)
            {
                cacheTasks.Add(_cache.RemoveByTagAsync($"donor_{userId}", cancellationToken).AsTask());
                cacheTasks.Add(_cache.RemoveByTagAsync($"donor_feed_{userId}", cancellationToken).AsTask());
            }

            await Task.WhenAll(cacheTasks);
        }
        catch (DbUpdateConcurrencyException)
        {
            _logger.LogError("Concurrency conflict while canceling request {RequestId}.", request.RequestId);
            return Result<CancelRequestResult>.Failure(DonationErrors.ConcurrencyConflict);
        }

        _logger.LogInformation("Donation request {RequestId} cancelled by hospital {HospitalId}.", request.RequestId, hospitalId);

        return Result<CancelRequestResult>.Success(
            new CancelRequestResult(donationRequest.Id, donationRequest.Status.ToString())
        );
    }
}