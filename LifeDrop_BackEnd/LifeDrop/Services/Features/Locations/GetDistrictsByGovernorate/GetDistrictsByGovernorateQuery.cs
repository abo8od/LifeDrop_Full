using Core.Common;
using Services.Features.Locations.Dtos;
using Services.Interfaces;

namespace Services.Features.Locations.GetDistrictsByGovernorate;

public record GetDistrictsByGovernorateQuery(Guid GovernorateId) : ICachedQuery<Result<List<LocationDto>>>
{
    public string CacheKey => $"ref:districts:{GovernorateId}";
    public string[] Tags => ["reference-data", "locations"];
    public TimeSpan Expiration => TimeSpan.FromHours(24);
}