using Core.Common;
using Core.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Interfaces;

namespace Services.Features.Notifications.RegisterDeviceToken;

public class RegisterDeviceTokenCommandHandler : IRequestHandler<RegisterDeviceTokenCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<RegisterDeviceTokenCommandHandler> _logger;

    public RegisterDeviceTokenCommandHandler(
        IUnitOfWork unitOfWork,
        ICurrentUserService currentUserService,
        ILogger<RegisterDeviceTokenCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result> Handle(RegisterDeviceTokenCommand request, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;

        // Upsert: if the token already exists (re-login on same device), reassign it to this user
        var existing = await _unitOfWork.DeviceTokens
            .Query()
            .FirstOrDefaultAsync(t => t.Token == request.Token, cancellationToken);

        if (existing != null)
        {
            existing.UserId = userId;
            existing.Platform = request.Platform;
            existing.ModifiedOn = DateTimeOffset.UtcNow;
        }
        else
        {
            await _unitOfWork.DeviceTokens.AddAsync(new DeviceToken
            {
                UserId = userId,
                Token = request.Token,
                Platform = request.Platform
            });
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Device token registered for user {UserId} ({Platform}).", userId, request.Platform);

        return Result.Success();
    }
}
