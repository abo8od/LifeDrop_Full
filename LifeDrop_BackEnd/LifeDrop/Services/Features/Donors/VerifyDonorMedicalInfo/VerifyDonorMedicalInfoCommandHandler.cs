using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Caching.Hybrid;

namespace Services.Features.Donors.VerifyDonorMedicalInfo;

public class VerifyDonorMedicalInfoCommandHandler 
    : IRequestHandler<VerifyDonorMedicalInfoCommand, Result<VerifyDonorMedicalInfoResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly INotificationService _notificationService;
    private readonly ILogger<VerifyDonorMedicalInfoCommandHandler> _logger;
    private readonly HybridCache _cache;

    public VerifyDonorMedicalInfoCommandHandler(
        IUnitOfWork unitOfWork, 
        INotificationService notificationService, 
        ILogger<VerifyDonorMedicalInfoCommandHandler> logger,
        HybridCache cache)
    {
        _unitOfWork = unitOfWork;
        _notificationService = notificationService;
        _logger = logger;
        _cache = cache;
    }

    public async Task<Result<VerifyDonorMedicalInfoResult>> Handle(
        VerifyDonorMedicalInfoCommand request,
        CancellationToken cancellationToken)
    {
        var donorProfile = await _unitOfWork.DonorProfiles
            .Query()
            .Include(p => p.User)
            .FirstOrDefaultAsync(
                p => p.UserId == request.DonorUserId 
                     && p.User.Role == Role.Donor,
                cancellationToken);
        
        if (donorProfile == null)
        {
            _logger.LogWarning("Medical verification failed: donor not found for user {DonorUserId}.", request.DonorUserId);
            return Result<VerifyDonorMedicalInfoResult>.Failure(DonorErrors.NotFound);
        }
        
        donorProfile.IsMedicallyVerified = true;

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        // Invalidate donor caches
        await Task.WhenAll(
            _cache.RemoveByTagAsync($"donor_{request.DonorUserId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"donor_feed_{request.DonorUserId}", cancellationToken).AsTask()
        );

        // Notify client to refresh SignalR groups as verification status affects Critical notifications
        await _notificationService.NotifyProfileUpdatedAsync(donorProfile.UserId, cancellationToken);

        _logger.LogInformation("Donor {DonorUserId} medically verified successfully.", request.DonorUserId);

        return Result<VerifyDonorMedicalInfoResult>.Success(
            new VerifyDonorMedicalInfoResult(
                donorProfile.UserId,
                donorProfile.IsMedicallyVerified
            )
        );
    }
}