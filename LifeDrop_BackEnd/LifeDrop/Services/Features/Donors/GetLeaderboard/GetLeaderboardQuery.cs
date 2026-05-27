using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Services.Interfaces;
using System.Text.Json.Serialization;

namespace Services.Features.Donors.GetLeaderboard;

/// <summary>
/// Query to retrieve the donor leaderboard.
/// Can filter by governorate for local rankings or get national rankings.
/// </summary>
public class GetLeaderboardQuery : ICachedQuery<Result<LeaderboardResponseDto>>
{
    /// <summary>
    /// Optional governorate ID to filter by specific region.
    /// If not provided, returns national leaderboard.
    /// </summary>
    public Guid? GovernorateId { get; set; }

    /// <summary>
    /// Number of top donors to return. Default is 10. Max is 100.
    /// </summary>
    public int TopN { get; set; } = 10;

    [JsonIgnore]
    [BindNever]
    public string CacheKey => $"leaderboard:gov:{GovernorateId?.ToString() ?? "national"}:top:{TopN}";
    
    [JsonIgnore]
    [BindNever]
    public string[] Tags => ["leaderboard"];
    
    [JsonIgnore]
    [BindNever]
    public TimeSpan Expiration => TimeSpan.FromMinutes(10);
}