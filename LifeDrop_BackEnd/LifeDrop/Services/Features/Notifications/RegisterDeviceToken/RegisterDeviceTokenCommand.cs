using Core.Common;
using Core.Enums;
using MediatR;

namespace Services.Features.Notifications.RegisterDeviceToken;

public record RegisterDeviceTokenCommand(string Token, DevicePlatform Platform) : IRequest<Result>;
