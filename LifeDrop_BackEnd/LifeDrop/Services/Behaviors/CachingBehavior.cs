using Core.Common;
using MediatR;
using Microsoft.Extensions.Caching.Hybrid;
using Microsoft.Extensions.Logging;
using Services.Interfaces;

namespace Services.Behaviors;

public class CachingBehavior<TRequest, TResponse>(
    HybridCache cache,
    ILogger<CachingBehavior<TRequest, TResponse>> logger)
    : IPipelineBehavior<TRequest, TResponse>
    where TRequest : notnull
{
    private readonly HybridCache _cache = cache;
    private readonly ILogger<CachingBehavior<TRequest, TResponse>> _logger = logger;

    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken ct)
    {
        if (request is not ICachedQuery cachedRequest)
            return await next(ct);

        _logger.LogDebug("Cache check: {RequestName} key={CacheKey}", typeof(TRequest).Name, cachedRequest.CacheKey);

        return await _cache.GetOrCreateAsync<TResponse>(
            cachedRequest.CacheKey,
            async _ =>
            {
                _logger.LogDebug("Cache miss: {RequestName}", typeof(TRequest).Name);
                return await next(ct);
            },
            new HybridCacheEntryOptions { Expiration = cachedRequest.Expiration },
            tags: cachedRequest.Tags,
            cancellationToken: ct);
    }
}