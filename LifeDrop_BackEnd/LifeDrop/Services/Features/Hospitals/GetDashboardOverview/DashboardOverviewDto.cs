using System;
using System.Collections.Generic;

namespace Services.Features.Hospitals.GetDashboardOverview;

public record RecentActivityDto(
    Guid Id,
    string ActivityType,
    string Description,
    DateTimeOffset Timestamp
);

public record ActiveRequestProgressDto(
    Guid RequestId,
    string BloodType,
    int TargetQuota,
    int CurrentFulfilledAcceptances,
    double ProgressPercentage
);

public record DashboardOverviewDto(
    int ActiveRequestsCount,
    int FulfilledRequestsCount,
    int CanceledRequestsCount,
    double CompletionRate,
    int TotalBloodBagsCollected,
    List<ActiveRequestProgressDto> ActiveRequestsProgress,
    List<RecentActivityDto> RecentActivities
);
