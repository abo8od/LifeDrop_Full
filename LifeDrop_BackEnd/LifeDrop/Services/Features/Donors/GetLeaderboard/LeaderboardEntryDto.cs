namespace Services.Features.Donors.GetLeaderboard;

/// <summary>
/// Represents a single entry in the leaderboard.
/// </summary>
public class LeaderboardEntryDto
{
    public int Rank { get; init; }
    public Guid DonorId { get; init; }
    public string FullName { get; init; } = string.Empty;
    public string? GovernorateName { get; init; }
    public int GamificationPoints { get; init; }
    public double ReliabilityScore { get; init; }
}