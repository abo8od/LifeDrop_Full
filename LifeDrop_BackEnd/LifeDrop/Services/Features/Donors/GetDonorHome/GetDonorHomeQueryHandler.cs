using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using Core.Helpers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Shared.Configuration;

namespace Services.Features.Donors.GetDonorHome;

public class GetDonorHomeQueryHandler : IRequestHandler<GetDonorHomeQuery, Result<DonorHomeDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<GetDonorHomeQueryHandler> _logger;

    public GetDonorHomeQueryHandler(
        IUnitOfWork unitOfWork,
        IOptions<DonationSettings> donationSettings,
        ILogger<GetDonorHomeQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<DonorHomeDto>> Handle(GetDonorHomeQuery request, CancellationToken cancellationToken)
    {
        var profile = await _unitOfWork.DonorProfiles
            .Query()
            .AsNoTracking()
            .Where(p => p.UserId == request.UserId)
            .Select(p => new
            {
                p.BloodType,
                p.GovernorateId,
                p.LastDonationDate,
                UserFirstName = p.User.FirstName,
                UserLastName = p.User.LastName,
                TotalContributions = p.DonationAcceptances.Count(da => da.Status == AcceptanceStatus.Fulfilled),
                LastHospitalName = p.DonationAcceptances
                    .Where(da => da.Status == AcceptanceStatus.Fulfilled)
                    .OrderByDescending(da => da.FulfilledAt)
                    .Select(da => da.DonationRequest.Hospital.Name)
                    .FirstOrDefault()
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (profile == null)
        {
            _logger.LogWarning("Donor home failed: profile not found for user {UserId}.", request.UserId);
            return Result<DonorHomeDto>.Failure(DonorErrors.NotFound);
        }

        var remainingDays = 0;
        if (profile.LastDonationDate.HasValue)
        {
            var daysSince = (DateTimeOffset.UtcNow - profile.LastDonationDate.Value).TotalDays;
            if (daysSince < _donationSettings.CooldownDays)
                remainingDays = (int)Math.Ceiling(_donationSettings.CooldownDays - daysSince);
        }

        var activeRequests = new List<ActiveRequestSummaryDto>();

        if (profile.BloodType.HasValue && profile.GovernorateId.HasValue)
        {
            var compatibleTypes = profile.BloodType.Value.GetCompatibleRecipientBloodTypes().ToList();
            var governorateId = profile.GovernorateId.Value;

            activeRequests = await _unitOfWork.DonationRequests
                .Query()
                .AsNoTracking()
                .Where(r => r.Status == RequestStatus.Active)
                .Where(r => r.ExpiryDate > DateTime.UtcNow)
                .Where(r => compatibleTypes.Contains(r.BloodType))
                .Where(r => r.CurrentActiveAcceptances < r.TargetQuota)
                .Where(r => r.RequestDistricts.Any(rd => rd.District!.GovernorateId == governorateId))
                .OrderByDescending(r => r.Urgency == UrgencyLevel.Critical ? 2 : r.Urgency == UrgencyLevel.Urgent ? 1 : 0)
                .ThenByDescending(r => r.CreatedOn)
                .Take(4)
                .Select(r => new ActiveRequestSummaryDto(
                    r.Id,
                    r.Hospital.Name,
                    r.BloodType.ToString(),
                    r.Urgency.ToString(),
                    r.TargetQuota - r.CurrentActiveAcceptances
                ))
                .ToListAsync(cancellationToken);
        }

        var lastHospital = profile.LastHospitalName ?? "NONE";
        _logger.LogWarning("DEBUG lastHospital value: '{Value}'", lastHospital);

        var dto = new DonorHomeDto(
            Username: $"{profile.UserFirstName} {profile.UserLastName}",
            RemainingDays: remainingDays,
            LastHospitalName: lastHospital,
            TotalContributions: profile.TotalContributions,
            ActiveRequests: activeRequests
        );

        _logger.LogWarning("DEBUG dto.LastHospitalName: '{Value}'", dto.LastHospitalName);

        return Result<DonorHomeDto>.Success(dto);
    }
}
