using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.DonationRequests.Queries.GetHospitalRequests;
using Services.Interfaces;
using Shared.Responses;
using Microsoft.Extensions.Logging;

namespace Services.Features.DonationRequests.Queries.GetHospitalRequests;

/// <summary>
/// Handler for GetHospitalRequestsQuery.
/// Retrieves all donation requests for the current hospital, filtered by status.
/// Uses LINQ Select projections for optimized database queries.
/// </summary>
public class GetHospitalRequestsQueryHandler : IRequestHandler<GetHospitalRequestsQuery, Result<PagedResponse<HospitalRequestSummaryDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetHospitalRequestsQueryHandler> _logger;

    public GetHospitalRequestsQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetHospitalRequestsQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<PagedResponse<HospitalRequestSummaryDto>>> Handle(GetHospitalRequestsQuery request, CancellationToken cancellationToken)
    {
        // Ensure hospital ID is available (should be set by authorization policy)
        if (!_currentUserService.HospitalId.HasValue)
        {
            _logger.LogWarning("Hospital requests retrieval failed: no hospital context available for user {UserId}.", _currentUserService.UserId);
                return Result<PagedResponse<HospitalRequestSummaryDto>>.Failure(HospitalErrors.HospitalMismatch);
        }

        var hospitalId = _currentUserService.HospitalId.Value;

        // Build query filtering by hospital
        var query = _unitOfWork.DonationRequests
            .Query()
            .AsNoTracking()
            .Where(r => r.HospitalId == hospitalId);

        // Filter by status if provided
        if (request.Status.HasValue)
        {
            query = query.Where(r => r.Status == request.Status.Value);
        }

        // Filter by search term
        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            var searchTermLower = request.SearchTerm.ToLower();
            query = query.Where(r => r.Hospital!.Name.ToLower().Contains(searchTermLower));
        }

        // Order by creation date (newest first)
        query = query.OrderByDescending(r => r.CreatedOn);

        // Get total count for pagination
        var totalCount = await query.CountAsync(cancellationToken);

        // Apply pagination and project to DTO
        var skip = (request.PageNumber - 1) * request.PageSize;
        var items = await query
            .Skip(skip)
            .Take(request.PageSize)
            .Select(r => new HospitalRequestSummaryDto
            {
                RequestId = r.Id,
                BloodType = r.BloodType.ToString(),
                Urgency = r.Urgency.ToString(),
                Status = r.Status.ToString(),
                TargetQuota = r.TargetQuota,
                CurrentActiveAcceptances = r.CurrentActiveAcceptances,
                CurrentFulfilledAcceptances = r.CurrentFulfilledAcceptances,
                CreatedAt = r.CreatedOn,
                ExpiryDate = r.ExpiryDate
            })
            .ToListAsync(cancellationToken);

        var response = new PagedResponse<HospitalRequestSummaryDto>(items, totalCount, request.PageNumber, request.PageSize);

        return Result<PagedResponse<HospitalRequestSummaryDto>>.Success(response);
    }
}