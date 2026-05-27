using Core.Common;
using Services.Features.ReferenceData.Dtos;
using Services.Interfaces;

namespace Services.Features.ReferenceData.GetBloodTypes;

public record GetBloodTypesQuery : ICachedQuery<Result<List<BloodTypeDto>>>
{
    public string CacheKey => "ref:bloodtypes";
    public string[] Tags => ["reference-data"];
    public TimeSpan Expiration => TimeSpan.FromHours(24);
}