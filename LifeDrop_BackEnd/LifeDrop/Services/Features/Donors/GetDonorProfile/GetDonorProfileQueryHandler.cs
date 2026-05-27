using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Features.Donors.GetDonorProfile;
using Services.Interfaces;
using Shared.Configuration;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.GetDonorProfile;

public class GetDonorProfileQueryHandler : IRequestHandler<GetDonorProfileQuery, Result<DonorProfileDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<GetDonorProfileQueryHandler> _logger;

    public GetDonorProfileQueryHandler(
        IUnitOfWork unitOfWork,
        ICurrentUserService currentUserService,
        IOptions<DonationSettings> donationSettings,
        ILogger<GetDonorProfileQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<DonorProfileDto>> Handle(GetDonorProfileQuery request, CancellationToken cancellationToken)
    {
        var userId = request.UserId;

        var profile = await _unitOfWork.DonorProfiles
    .Query()
    .AsNoTracking()
    .Where(p => p.UserId == userId)
    .Select(p => new
    {
        p.Id,
        p.UserId,
        p.BloodType,
        p.IsMedicallyVerified,
        p.IsAvailable,
        p.GovernorateId,
        p.DistrictId,
        p.ReliabilityScore,
        p.GamificationPoints,
        p.LastDonationDate,

        GovernorateName = p.Governorate != null ? p.Governorate.Name : null,
        DistrictName = p.District != null ? p.District.Name : null,

        UserFirstName = p.User != null ? p.User.FirstName : null,
        UserLastName = p.User != null ? p.User.LastName : null,
        UserEmail = p.User != null ? p.User.Email : null,
        UserPhone = p.User != null ? p.User.PhoneNumber : null,

        TotalDonations = p.DonationAcceptances.Count(da => da.Status == AcceptanceStatus.Fulfilled),
        p.ReceiveCriticalNotifications,
        p.ReceiveUrgentNotifications,
        p.ReceiveNormalNotifications
    })
    .FirstOrDefaultAsync(cancellationToken);

    if (profile == null)
    {
        _logger.LogWarning("Donor profile not found for user {UserId}.", userId);
        return Result<DonorProfileDto>.Failure(DonorErrors.NotFound);
    }
    
    var isEligible = true;
    DateTimeOffset? nextEligibleDate = null;

    if (profile.LastDonationDate.HasValue)
    {
        var daysSince = (DateTime.UtcNow - profile.LastDonationDate.Value.UtcDateTime).TotalDays;

        isEligible = daysSince >= _donationSettings.CooldownDays;

        if (!isEligible)
        {
            nextEligibleDate = profile.LastDonationDate.Value.AddDays(_donationSettings.CooldownDays);
        }
    }

    var dto = new DonorProfileDto
    {
        UserId = profile.UserId,
        FirstName = profile.UserFirstName ?? "",
        LastName = profile.UserLastName ?? "",
        Email = profile.UserEmail ?? "",
        PhoneNumber = profile.UserPhone ?? "",
        BloodType = profile.BloodType.ToString(),
        IsMedicallyVerified = profile.IsMedicallyVerified,
        IsAvailable = profile.IsAvailable,
        GovernorateName = profile.GovernorateName,
        DistrictName = profile.DistrictName,
        ReliabilityScore = profile.ReliabilityScore,
        GamificationPoints = profile.GamificationPoints,
        LastDonationDate = profile.LastDonationDate,
        IsEligibleToDonate = isEligible,
        NextEligibleDate = nextEligibleDate,
        TotalDonations = profile.TotalDonations,
        ReceiveCriticalNotifications = profile.ReceiveCriticalNotifications,
        ReceiveUrgentNotifications = profile.ReceiveUrgentNotifications,
        ReceiveNormalNotifications = profile.ReceiveNormalNotifications
    };

        return Result<DonorProfileDto>.Success(dto);
    }
}