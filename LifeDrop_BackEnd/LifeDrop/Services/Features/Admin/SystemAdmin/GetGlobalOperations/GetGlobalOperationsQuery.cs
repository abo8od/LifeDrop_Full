using Core.Common;
using MediatR;
using Services.Interfaces;

namespace Services.Features.Admin.SystemAdmin.GetGlobalOperations;

public class GetGlobalOperationsQuery : ICachedQuery<Result<GlobalOperationsDto>>
{
    public string CacheKey => "admin:global_ops";
    public string[] Tags => ["admin_stats"];
    public TimeSpan Expiration => TimeSpan.FromMinutes(5);
}
