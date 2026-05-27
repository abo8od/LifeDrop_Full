using Core.Common;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Interfaces;

namespace Services.Features.Notifications.UnregisterDeviceToken;

public class UnregisterDeviceTokenCommandHandler : IRequestHandler<UnregisterDeviceTokenCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<UnregisterDeviceTokenCommandHandler> _logger;

    public UnregisterDeviceTokenCommandHandler(
        IUnitOfWork unitOfWork,
        ICurrentUserService currentUserService,
        ILogger<UnregisterDeviceTokenCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result> Handle(UnregisterDeviceTokenCommand request, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;

        await _unitOfWork.DeviceTokens
            .Query()
            .Where(t => t.Token == request.Token && t.UserId == userId)
            .ExecuteDeleteAsync(cancellationToken);

        _logger.LogInformation("Device token unregistered for user {UserId}.", userId);

        return Result.Success();
    }
}
