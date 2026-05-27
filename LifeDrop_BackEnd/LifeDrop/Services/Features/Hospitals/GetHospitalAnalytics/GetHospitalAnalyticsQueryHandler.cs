using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;

namespace Services.Features.Hospitals.GetHospitalAnalytics;

public class GetHospitalAnalyticsQueryHandler : IRequestHandler<GetHospitalAnalyticsQuery, Result<HospitalAnalyticsDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;

    public GetHospitalAnalyticsQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
    }

    public async Task<Result<HospitalAnalyticsDto>> Handle(GetHospitalAnalyticsQuery request, CancellationToken cancellationToken)
    {
        var hospitalId = request.HospitalId;
        var sixMonthsAgo = DateTime.UtcNow.AddMonths(-6);

        // 1. Monthly Donation Stats (Last 6 Months)
        var monthlyStatsData = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonationRequest.HospitalId == hospitalId && 
                        a.Status == AcceptanceStatus.Fulfilled && 
                        a.FulfilledAt >= sixMonthsAgo)
            .GroupBy(a => new { a.FulfilledAt!.Value.Year, a.FulfilledAt.Value.Month })
            .Select(g => new
            {
                Year = g.Key.Year,
                Month = g.Key.Month,
                Count = g.Count()
            })
            .ToListAsync(cancellationToken);

        var monthlyDonationStats = new List<MonthlyStatsDto>();
        for (int i = 5; i >= 0; i--)
        {
            var date = DateTime.UtcNow.AddMonths(-i);
            var stat = monthlyStatsData.FirstOrDefault(s => s.Year == date.Year && s.Month == date.Month);
            monthlyDonationStats.Add(new MonthlyStatsDto(
                date.ToString("MMM yyyy"), 
                stat?.Count ?? 0));
        }

        // 2. Blood Type Distribution
        var bloodTypeData = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonationRequest.HospitalId == hospitalId && a.Status == AcceptanceStatus.Fulfilled)
            .GroupBy(a => a.DonationRequest.BloodType)
            .Select(g => new
            {
                BloodType = g.Key,
                Count = g.Count()
            })
            .ToListAsync(cancellationToken);

        int totalFulfilled = bloodTypeData.Sum(x => x.Count);
        var bloodTypeDistribution = bloodTypeData.Select(x => new BloodTypeStatDto(
            x.BloodType.ToString(),
            x.Count,
            totalFulfilled == 0 ? 0 : Math.Round((double)x.Count / totalFulfilled * 100, 2)
        )).ToList();

        // 3. Average Response Time (Request Created -> First Acceptance)
        // Optimized to only look at requests that actually have at least one acceptance
        var responseTimes = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonationRequest.HospitalId == hospitalId)
            .GroupBy(a => new { a.DonationRequestId, a.DonationRequest.CreatedOn })
            .Select(g => new
            {
                Minutes = (g.Min(a => a.AcceptedAt) - g.Key.CreatedOn.DateTime).TotalMinutes
            })
            .Where(x => x.Minutes >= 0)
            .ToListAsync(cancellationToken);

        double averageResponseTimeInMinutes = responseTimes.Any() 
            ? Math.Round(responseTimes.Average(x => x.Minutes), 2) 
            : 0;

        return Result<HospitalAnalyticsDto>.Success(new HospitalAnalyticsDto(
            monthlyDonationStats,
            bloodTypeDistribution,
            averageResponseTimeInMinutes
        ));
    }
}
