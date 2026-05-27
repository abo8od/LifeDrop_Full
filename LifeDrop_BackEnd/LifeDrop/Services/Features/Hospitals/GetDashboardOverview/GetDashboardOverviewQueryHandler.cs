using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace Services.Features.Hospitals.GetDashboardOverview;

public class GetDashboardOverviewQueryHandler : IRequestHandler<GetDashboardOverviewQuery, Result<DashboardOverviewDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;

    public GetDashboardOverviewQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
    }

    public async Task<Result<DashboardOverviewDto>> Handle(GetDashboardOverviewQuery request, CancellationToken cancellationToken)
    {
        var hospitalId = request.HospitalId;
        
        // 1. Combined query for status counts and total blood bags
        var statsData = await _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .Where(r => r.HospitalId == hospitalId)
            .GroupBy(_ => 1)
            .Select(g => new
            {
                ActiveCount = g.Count(r => r.Status == RequestStatus.Active),
                FulfilledCount = g.Count(r => r.Status == RequestStatus.Fulfilled),
                CancelledCount = g.Count(r => r.Status == RequestStatus.Cancelled),
                TotalBags = g.Sum(r => r.CurrentFulfilledAcceptances)
            })
            .FirstOrDefaultAsync(cancellationToken);

        int activeRequests = statsData?.ActiveCount ?? 0;
        int fulfilledRequests = statsData?.FulfilledCount ?? 0;
        int canceledRequests = statsData?.CancelledCount ?? 0;
        int totalBloodBagsCollected = statsData?.TotalBags ?? 0;

        int totalRequests = activeRequests + fulfilledRequests + canceledRequests;
        double completionRate = totalRequests == 0 ? 0 : Math.Round((double)fulfilledRequests / totalRequests * 100, 2);
        
        var activeRequestsProgress = await _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .Where(r => r.HospitalId == hospitalId && r.Status == RequestStatus.Active)
            .OrderBy(r => r.CreatedOn)
            .Take(5)
            .Select(r => new ActiveRequestProgressDto(
                r.Id,
                r.BloodType.ToString(),
                r.TargetQuota,
                r.CurrentFulfilledAcceptances,
                r.TargetQuota == 0 ? 0 : Math.Round((double)r.CurrentFulfilledAcceptances / r.TargetQuota * 100, 2)
            ))
            .ToListAsync(cancellationToken);

        
        // 3. Recent Activities (Fetch more to ensure top 10 after merging)
        var recentRequests = await _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .Where(r => r.HospitalId == hospitalId)
            .OrderByDescending(r => r.CreatedOn)
            .Take(10)
            .Select(r => new RecentActivityDto(
                r.Id,
                "RequestCreated",
                $"New donation request for blood type {r.BloodType}",
                r.CreatedOn
            ))
            .ToListAsync(cancellationToken);

        var recentAcceptances = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonationRequest.HospitalId == hospitalId && a.Status == AcceptanceStatus.Fulfilled && a.FulfilledAt.HasValue)
            .OrderByDescending(a => a.FulfilledAt)
            .Take(10)
            .Select(a => new RecentActivityDto(
                a.Id,
                "DonationFulfilled",
                $"Donation fulfilled by donor (Progress: {a.DonationRequest.CurrentFulfilledAcceptances}/{a.DonationRequest.TargetQuota})",
                new DateTimeOffset(a.FulfilledAt ?? DateTime.UtcNow, TimeSpan.Zero)
            ))
            .ToListAsync(cancellationToken);

        var topActivities = recentRequests.Concat(recentAcceptances)
            .OrderByDescending(a => a.Timestamp)
            .Take(10)
            .ToList();

        var dashboardDto = new DashboardOverviewDto(
            activeRequests,
            fulfilledRequests,
            canceledRequests,
            completionRate,
            totalBloodBagsCollected,
            activeRequestsProgress,
            topActivities
        );

        return Result<DashboardOverviewDto>.Success(dashboardDto);
    }
}
