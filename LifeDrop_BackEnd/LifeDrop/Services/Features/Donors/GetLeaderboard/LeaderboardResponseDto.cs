namespace Services.Features.Donors.GetLeaderboard;

/// <summary>
/// Response containing leaderboard entries.
/// </summary>
public class LeaderboardResponseDto
{
    public IReadOnlyList<LeaderboardEntryDto> Entries { get; init; } = Array.Empty<LeaderboardEntryDto>();
    public int TotalCount { get; init; }
    public string? Scope { get; init; } // "National" or GovernorateName
}