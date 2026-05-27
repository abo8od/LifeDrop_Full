using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Configuration;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.GetCooldownStatus;

public class GetCooldownStatusQueryHandler : IRequestHandler<GetCooldownStatusQuery, Result<CooldownStatusDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<GetCooldownStatusQueryHandler> _logger;

    public GetCooldownStatusQueryHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IOptions<DonationSettings> donationSettings,
        ILogger<GetCooldownStatusQueryHandler> _logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _donationSettings = donationSettings.Value;
        this._logger = _logger;
    }

    public async Task<Result<CooldownStatusDto>> Handle(GetCooldownStatusQuery request, CancellationToken cancellationToken)
    {
        var userId = request.UserId;

        var profile = await _unitOfWork.DonorProfiles.Query()
            .AsNoTracking()
            .FirstOrDefaultAsync(p => p.UserId == userId, cancellationToken);

        if (profile == null)
        {
            _logger.LogWarning("Cooldown status failed: donor profile not found for user {UserId}.", userId);
            return Result<CooldownStatusDto>.Failure(DonorErrors.NotFound);
        }

        if (!profile.LastDonationDate.HasValue)
        {
            return Result<CooldownStatusDto>.Success(new CooldownStatusDto(
                null,
                DateTimeOffset.UtcNow,
                0,
                true
            ));
        }

        var lastDonation = profile.LastDonationDate.Value;
        var nextEligibleDate = lastDonation.AddDays(_donationSettings.CooldownDays);
        var today = DateTimeOffset.UtcNow;

        var daysRemaining = (int)Math.Ceiling((nextEligibleDate - today).TotalDays);
        if (daysRemaining < 0) daysRemaining = 0;

        var isEligible = today >= nextEligibleDate;

        return Result<CooldownStatusDto>.Success(new CooldownStatusDto(
            lastDonation,
            nextEligibleDate,
            daysRemaining,
            isEligible
        ));
    }
}
