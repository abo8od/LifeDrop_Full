using System.Collections.Generic;

namespace Services.Features.Hospitals.GetHospitalAnalytics;

public record MonthlyStatsDto(string Month, int DonationCount);

public record BloodTypeStatDto(string BloodType, int Count, double Percentage);

public record HospitalAnalyticsDto(
    List<MonthlyStatsDto> MonthlyDonationStats,
    List<BloodTypeStatDto> BloodTypeDistribution,
    double AverageResponseTimeInMinutes
);
