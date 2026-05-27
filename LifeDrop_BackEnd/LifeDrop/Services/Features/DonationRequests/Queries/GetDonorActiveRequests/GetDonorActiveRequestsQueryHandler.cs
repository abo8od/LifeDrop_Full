using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using Core.Helpers;
using MediatR;
using Microsoft.EntityFrameworkCore; // EF.Functions.ILike
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Shared.Responses;
using AcceptanceStatus = Core.Enums.AcceptanceStatus;
using RequestStatus = Core.Enums.RequestStatus;

namespace Services.Features.DonationRequests.Queries.GetDonorActiveRequests;

public class GetDonorActiveRequestsQueryHandler
    : IRequestHandler<GetDonorActiveRequestsQuery, Result<PagedResponse<DonorActiveRequestDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<GetDonorActiveRequestsQueryHandler> _logger;

    public GetDonorActiveRequestsQueryHandler(
        IUnitOfWork unitOfWork,
        ILogger<GetDonorActiveRequestsQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<Result<PagedResponse<DonorActiveRequestDto>>> Handle(
        GetDonorActiveRequestsQuery request,
        CancellationToken cancellationToken)
    {
        var profile = await _unitOfWork.DonorProfiles
            .Query()
            .AsNoTracking()
            .Where(p => p.UserId == request.UserId)
            .Select(p => new { p.Id, p.BloodType, p.GovernorateId })
            .FirstOrDefaultAsync(cancellationToken);

        if (profile == null)
        {
            _logger.LogWarning("Active requests browse failed: donor profile not found for user {UserId}.", request.UserId);
            return Result<PagedResponse<DonorActiveRequestDto>>.Failure(DonorErrors.NotFound);
        }

        // Blood type or location not set — return empty page, not an error.
        if (!profile.BloodType.HasValue || !profile.GovernorateId.HasValue)
        {
            return Result<PagedResponse<DonorActiveRequestDto>>.Success(
                new PagedResponse<DonorActiveRequestDto>([], 0, request.PageNumber, request.PageSize));
        }

        var compatibleTypes = profile.BloodType.Value.GetCompatibleRecipientBloodTypes().ToList();
        var governorateId = profile.GovernorateId.Value;
        var donorProfileId = profile.Id;

        var baseQuery = _unitOfWork.DonationRequests
            .Query()
            .AsNoTracking()
            .Where(r => r.Status == RequestStatus.Active)
            .Where(r => r.ExpiryDate > DateTime.UtcNow)
            .Where(r => compatibleTypes.Contains(r.BloodType))
            .Where(r => r.CurrentActiveAcceptances < r.TargetQuota)
            .Where(r => r.RequestDistricts.Any(rd => rd.District!.GovernorateId == governorateId))
            .Where(r => !r.Acceptances.Any(a => a.DonorProfileId == donorProfileId && a.Status == AcceptanceStatus.Accepted));

        if (request.Urgency.HasValue)
            baseQuery = baseQuery.Where(r => r.Urgency == request.Urgency.Value);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            var term = request.SearchTerm.Trim().ToLowerInvariant();
            baseQuery = baseQuery.Where(r => r.Hospital!.Name.ToLower().Contains(term));
        }

        var totalCount = await baseQuery.CountAsync(cancellationToken);

        var items = await baseQuery
            .OrderByDescending(r => r.Urgency)
            .ThenByDescending(r => r.CreatedOn)
            .Skip((request.PageNumber - 1) * request.PageSize)
            .Take(request.PageSize)
            .Select(r => new DonorActiveRequestDto(
                r.Id,
                r.Hospital!.Name,
                r.RequestDistricts.FirstOrDefault()!.District!.Governorate!.Name,
                r.BloodType.ToString(),
                r.Urgency.ToString(),
                r.TargetQuota - r.CurrentActiveAcceptances,
                r.ExpiryDate,
                r.Hospital.Latitude,
                r.Hospital.Longitude
            ))
            .ToListAsync(cancellationToken);

        return Result<PagedResponse<DonorActiveRequestDto>>.Success(
            new PagedResponse<DonorActiveRequestDto>(items, totalCount, request.PageNumber, request.PageSize));
    }
}
