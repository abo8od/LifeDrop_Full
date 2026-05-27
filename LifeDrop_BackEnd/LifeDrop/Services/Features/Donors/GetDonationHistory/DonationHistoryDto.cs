using System;
using Core.Enums;

namespace Services.Features.Donors.GetDonationHistory;

public record DonationHistoryDto(
    Guid AcceptanceId,
    Guid RequestId,
    string HospitalName,
    string BloodType,
    DateTimeOffset Date,
    string Status,
    int PointsEarned
);
