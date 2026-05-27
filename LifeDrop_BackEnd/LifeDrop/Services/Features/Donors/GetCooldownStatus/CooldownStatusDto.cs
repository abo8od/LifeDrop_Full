using System;

namespace Services.Features.Donors.GetCooldownStatus;

public record CooldownStatusDto(
    DateTimeOffset? LastDonationDate,
    DateTimeOffset NextEligibleDate,
    int DaysRemaining,
    bool IsEligible
);
