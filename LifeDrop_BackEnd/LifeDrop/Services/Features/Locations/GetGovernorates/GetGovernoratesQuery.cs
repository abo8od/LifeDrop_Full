using Core.Common;
using Services.Features.Locations.Dtos;
using Services.Interfaces;

namespace Services.Features.Locations.GetGovernorates;

public record GetGovernoratesQuery : ICachedQuery<Result<List<LocationDto>>>
{
    public string CacheKey => "ref:governorates";
    public string[] Tags => ["reference-data", "locations"];
    public TimeSpan Expiration => TimeSpan.FromHours(24);
}