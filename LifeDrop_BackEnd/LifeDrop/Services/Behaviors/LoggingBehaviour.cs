using MediatR.Pipeline;
using Microsoft.Extensions.Logging;
using Services.Interfaces;

namespace Services.Behaviors;

public class LoggingBehaviour<TRequest>(ILogger<TRequest> logger, ICurrentUserService currentUserService)
    : IRequestPreProcessor<TRequest>
    where TRequest : notnull
{
    private readonly ILogger<TRequest> _logger = logger;
    private readonly ICurrentUserService _currentUserService = currentUserService;

    public Task Process(TRequest request, CancellationToken cancellationToken)
    {
        var requestName = typeof(TRequest).Name;
        var userId = _currentUserService.UserId;
        var userEmail = _currentUserService.Email;

        _logger.LogDebug(
            "LifeDrop Request: {Name} {@UserId} {@UserEmail}", 
            requestName, userId, userEmail);

        return Task.CompletedTask;
    }
}