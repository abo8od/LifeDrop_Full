using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Services.Interfaces;
using Shared.Requests;
using Shared.Responses;
using System.Text.Json.Serialization;

namespace Services.Features.Donors.GetGamificationHistory;

public class GetGamificationHistoryQuery : PagedRequest, ICachedQuery<Result<PagedResponse<GamificationHistoryDto>>>
{
    [JsonIgnore]
    [BindNever]
    public Guid? UserId { get; set; }

    [JsonIgnore]
    [BindNever]
    public string CacheKey => $"gamification:donor:{UserId}:page:{PageNumber}:size:{PageSize}";
    
    [JsonIgnore]
    [BindNever]
    public string[] Tags => [$"donor_gamification_{UserId}"];
    
    [JsonIgnore]
    [BindNever]
    public TimeSpan Expiration => TimeSpan.FromMinutes(5);
}
