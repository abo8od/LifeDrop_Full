using Core.Common;
using MediatR;
using Services.Interfaces;

namespace Services.Features.Donors.GetCooldownStatus;

public record GetCooldownStatusQuery(Guid UserId) : ICachedQuery<Result<CooldownStatusDto>>
{
    public string CacheKey => $"cooldown:donor:{UserId}";
    public string[] Tags => [$"donor_{UserId}"];
    
    public TimeSpan Expiration 
    {
        get
        {
            var now = DateTime.UtcNow;
            var midnight = now.Date.AddDays(1);
            return midnight - now;
        }
    }
}
