using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using Core.Helpers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Features.DonationRequests.Queries.GetDonorFeed;
using Services.Interfaces;
using Shared.Configuration;
using Shared.Responses;
using Microsoft.Extensions.Logging;
using RequestStatus = Core.Enums.RequestStatus;
using AcceptanceStatus = Core.Enums.AcceptanceStatus;

namespace Services.Features.DonationRequests.Queries.GetDonorFeed;

/// <summary>
/// Handler for GetDonorFeedQuery.
/// Retrieves active donation requests that match the donor's location and blood type compatibility.
/// Uses LINQ Select projections for optimized database queries.
/// </summary>
public class GetDonorFeedQueryHandler : IRequestHandler<GetDonorFeedQuery, Result<PagedResponse<DonationRequestFeedDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<GetDonorFeedQueryHandler> _logger;

    public GetDonorFeedQueryHandler(
        IUnitOfWork unitOfWork, 
        ICurrentUserService currentUserService,
        IOptions<DonationSettings> donationSettings,
        ILogger<GetDonorFeedQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task<Result<PagedResponse<DonationRequestFeedDto>>> Handle(GetDonorFeedQuery request, CancellationToken cancellationToken)
    {
        // 1. Get current donor's profile to find their location and blood type
        var donorProfile = await _unitOfWork.DonorProfiles
            .Query()
            .AsNoTracking()
            .FirstOrDefaultAsync(p => p.UserId == _currentUserService.UserId, cancellationToken);

        if (donorProfile == null)
        {
            _logger.LogWarning("Donor feed retrieval failed: donor profile not found for user {UserId}.", _currentUserService.UserId);
                return Result<PagedResponse<DonationRequestFeedDto>>.Failure(DonorErrors.NotFound);
        }

        if (!donorProfile.BloodType.HasValue)
        {
            _logger.LogWarning("Donor feed retrieval failed: donor {UserId} has no blood type set.", _currentUserService.UserId);
                return Result<PagedResponse<DonationRequestFeedDto>>.Failure(DonationErrors.BloodTypeNotSet);
        }

        // Check if donor is available
        if (! donorProfile.IsAvailable)
        {
                return Result<PagedResponse<DonationRequestFeedDto>>.Failure(DonationErrors.DonorNotAvailable);
        }

        // Check cooldown period (eligibility)
        if (donorProfile.LastDonationDate.HasValue)
        {
            var daysSinceLastDonation = (DateTimeOffset.UtcNow - donorProfile.LastDonationDate.Value).TotalDays;
            if (daysSinceLastDonation < _donationSettings.CooldownDays)
            {
                var nextEligibleDate = donorProfile.LastDonationDate.Value.AddDays(_donationSettings.CooldownDays);
                return Result<PagedResponse<DonationRequestFeedDto>>.Failure(DonationErrors.InCooldownAt(nextEligibleDate));
            }
        }

        // 2. Get compatible blood types for this donor (who they can donate to)
        var compatibleBloodTypes = donorProfile.BloodType.Value.GetCompatibleRecipientBloodTypes().ToList();

        // 3. Get donor's location IDs (governorate and district)
        var donorGovernorateId = donorProfile.GovernorateId;
        var donorDistrictId = donorProfile.DistrictId;
        var donorUserId = _currentUserService.UserId;

        // 4. Build the query with all filters
        var baseQuery = _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .Where(r => r.Status == RequestStatus.Active)
            .Where(r => r.ExpiryDate > DateTime.UtcNow)
            .Where(r => compatibleBloodTypes.Contains(r.BloodType))
            // Filter by location: requests in donor's governorate or district
            .Where(r => r.RequestDistricts.Any(rd => 
                rd.District!.GovernorateId == donorGovernorateId || 
                rd.DistrictId == donorDistrictId))
            // Exclude already accepted
            .Where(r => !r.Acceptances.Any(a => a.DonorProfile!.UserId == donorUserId && a.Status == AcceptanceStatus.Accepted));

        // 6. Apply additional filters
        if (request.Urgency.HasValue)
        {
            baseQuery = baseQuery.Where(r => r.Urgency == request.Urgency.Value);
        }

        if (!donorProfile.IsMedicallyVerified)
        {
            baseQuery = baseQuery.Where(r => r.Urgency != UrgencyLevel.Critical);
        }

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            var term = request.SearchTerm.Trim().ToLowerInvariant();
            baseQuery = baseQuery.Where(r => r.Hospital!.Name.ToLower().Contains(term));
        }

        // 7. Get total count for pagination
        var totalCount = await baseQuery.CountAsync(cancellationToken);

        // 8. Single projection directly to DTO — eliminates the intermediate anonymous-type allocation
        var skip = (request.PageNumber - 1) * request.PageSize;

        var items = await baseQuery
            .OrderBy(r => r.RequestDistricts.Any(rd => rd.DistrictId == donorDistrictId) ? 1 : 2)
            .ThenByDescending(r => r.Urgency == UrgencyLevel.Critical ? 2 : r.Urgency == UrgencyLevel.Urgent ? 1 : 0)
            .ThenBy(r => r.ExpiryDate)
            .Skip(skip)
            .Take(request.PageSize)
            .Select(r => new DonationRequestFeedDto
            {
                RequestId = r.Id,
                HospitalName = r.Hospital!.Name,
                GovernorateName = r.RequestDistricts.FirstOrDefault()!.District!.Governorate!.Name,
                RequiredBloodType = r.BloodType.ToString(),
                TargetQuota = r.TargetQuota,
                RemainingQuota = r.TargetQuota - r.CurrentActiveAcceptances,
                Urgency = r.Urgency.ToString(),
                ExpiryDate = r.ExpiryDate,
                DistancePriority = r.RequestDistricts.Any(rd => rd.DistrictId == donorDistrictId) ? 1 : 2,
                HospitalLatitude = r.Hospital.Latitude,
                HospitalLongitude = r.Hospital.Longitude
            })
            .ToListAsync(cancellationToken);

        var response = new PagedResponse<DonationRequestFeedDto>(items, totalCount, request.PageNumber, request.PageSize);

        return Result<PagedResponse<DonationRequestFeedDto>>.Success(response);
    }
}