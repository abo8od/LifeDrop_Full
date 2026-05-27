using Core.Common;
using MediatR;

namespace Services.Features.Notifications.UnregisterDeviceToken;

public record UnregisterDeviceTokenCommand(string Token) : IRequest<Result>;
