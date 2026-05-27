using System.Diagnostics;
using MediatR;
using Microsoft.Extensions.Logging;
using Services.Interfaces;

namespace Services.Behaviors;

public class PerformanceBehaviour<TRequest, TResponse>(
    ILogger<TRequest> logger,
    ICurrentUserService currentUserService)
    : IPipelineBehavior<TRequest, TResponse>
    where TRequest : notnull
{
    private readonly ILogger<TRequest> _logger = logger;
    private readonly ICurrentUserService _currentUserService = currentUserService;

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var start = Stopwatch.GetTimestamp();

        var response = await next(cancellationToken);

        var elapsedMs = (long)Stopwatch.GetElapsedTime(start).TotalMilliseconds;

        if (elapsedMs > 200)
        {
            var requestName = typeof(TRequest).Name;
            var userId = _currentUserService.UserId;
            var userEmail = _currentUserService.Email;
            var traceId = Activity.Current?.TraceId.ToString() ?? "no-trace";

            if (elapsedMs > 500)
            {
                _logger.LogWarning(
                    "LifeDrop CRITICAL Latency: {Name} ({ElapsedMs}ms) UserId={UserId} Email={UserEmail} TraceId={TraceId}",
                    requestName, elapsedMs, userId, userEmail, traceId);
            }
            else
            {
                _logger.LogInformation(
                    "LifeDrop Moderate Latency: {Name} ({ElapsedMs}ms) UserId={UserId} TraceId={TraceId}",
                    requestName, elapsedMs, userId, traceId);
            }
        }

        return response;
    }
}
