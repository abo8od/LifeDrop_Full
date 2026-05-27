using System;

namespace Services.Features.Donors.GetGamificationHistory;

public record GamificationHistoryDto(
    Guid Id,
    int Points,
    string ActionType,
    string Description,
    DateTimeOffset CreatedOn
);
