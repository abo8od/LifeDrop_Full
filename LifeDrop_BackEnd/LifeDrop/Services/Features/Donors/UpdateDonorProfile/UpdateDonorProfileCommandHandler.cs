using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Hybrid;
using Services.Abstractions.Persistence;
using Services.Features.Donors.UpdateDonorProfile;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.UpdateDonorProfile;

public class UpdateDonorProfileCommandHandler : IRequestHandler<UpdateDonorProfileCommand, Result<UpdateDonorProfileResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly INotificationService _notificationService;
    private readonly HybridCache _cache;
    private readonly ILogger<UpdateDonorProfileCommandHandler> _logger;

    public UpdateDonorProfileCommandHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        INotificationService notificationService,
        HybridCache cache,
        ILogger<UpdateDonorProfileCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _notificationService = notificationService;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<UpdateDonorProfileResult>> Handle(UpdateDonorProfileCommand request, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;

        var profile = await _unitOfWork.DonorProfiles
            .Query()
            .Include(p => p.User)
            .Include(p => p.Governorate)
            .Include(p => p.District)
            .FirstOrDefaultAsync(p => p.UserId == userId, cancellationToken);

        if (profile == null)
        {
            _logger.LogWarning("Profile update failed: donor profile not found for user {UserId}.", userId);
            return Result<UpdateDonorProfileResult>.Failure(DonorErrors.NotFound);
        }

        // Update User details if provided
        if (!string.IsNullOrWhiteSpace(request.FirstName))
        {
            profile.User.FirstName = request.FirstName.Trim();
        }

        if (!string.IsNullOrWhiteSpace(request.LastName))
        {
            profile.User.LastName = request.LastName.Trim();
        }

        if (!string.IsNullOrWhiteSpace(request.PhoneNumber))
        {
            profile.User.PhoneNumber = request.PhoneNumber.Trim();
        }

        // Update Blood Type if provided
        if (!string.IsNullOrWhiteSpace(request.BloodType))
        {
            if (Enum.TryParse<BloodType>(request.BloodType, true, out var bloodType))
            {
                profile.BloodType = bloodType;
            }
            else
            {
                _logger.LogWarning("Profile update failed: invalid blood type '{BloodType}' for user {UserId}.", request.BloodType, userId);
                return Result<UpdateDonorProfileResult>.Failure(DonorErrors.InvalidBloodType);
            }
        }

        if (request.IsAvailable.HasValue)
        {
            profile.IsAvailable = request.IsAvailable.Value;
        }

        if (request.GovernorateId.HasValue)
        {
            var governorateExists = await _unitOfWork.Governorates
                .Query()
                .AnyAsync(g => g.Id == request.GovernorateId.Value, cancellationToken);

            if (!governorateExists)
            {
                _logger.LogWarning("Profile update failed: governorate {GovernorateId} not found.", request.GovernorateId.Value);
                return Result<UpdateDonorProfileResult>.Failure(LocationErrors.GovernorateNotFound);
            }

            profile.GovernorateId = request.GovernorateId.Value;
        }

        if (request.DistrictId.HasValue)
        {
            var districtExists = await _unitOfWork.Districts
                .Query()
                .AnyAsync(d => d.Id == request.DistrictId.Value &&
                             (!request.GovernorateId.HasValue || d.GovernorateId == request.GovernorateId.Value),
                             cancellationToken);

            if (!districtExists)
            {
                _logger.LogWarning("Profile update failed: district {DistrictId} not found.", request.DistrictId.Value);
                return Result<UpdateDonorProfileResult>.Failure(LocationErrors.DistrictNotFound);
            }

            profile.DistrictId = request.DistrictId.Value;
        }

        // Update Notification Settings if provided
        if (request.ReceiveCriticalNotifications.HasValue)
        {
            profile.ReceiveCriticalNotifications = request.ReceiveCriticalNotifications.Value;
        }

        if (request.ReceiveUrgentNotifications.HasValue)
        {
            profile.ReceiveUrgentNotifications = request.ReceiveUrgentNotifications.Value;
        }

        if (request.ReceiveNormalNotifications.HasValue)
        {
            profile.ReceiveNormalNotifications = request.ReceiveNormalNotifications.Value;
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        await Task.WhenAll(
            _cache.RemoveByTagAsync("leaderboard", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"donor_{userId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"donor_feed_{userId}", cancellationToken).AsTask()
        );

        // Notify client to refresh SignalR groups (PRD 3.2 & MS 1.4)
        await _notificationService.NotifyProfileUpdatedAsync(userId, cancellationToken);

        _logger.LogInformation("Donor profile updated successfully for user {UserId}.", userId);

        return Result<UpdateDonorProfileResult>.Success(
            new UpdateDonorProfileResult(
                profile.User.FirstName,
                profile.User.LastName,
                profile.User.PhoneNumber,
                profile.BloodType?.ToString(),
                profile.IsAvailable,
                profile.GovernorateId,
                profile.DistrictId,
                profile.ReceiveCriticalNotifications,
                profile.ReceiveUrgentNotifications,
                profile.ReceiveNormalNotifications
            )
        );
    }
}