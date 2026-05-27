using Core.Common;
using MediatR;
using Services.Features.Auth;

namespace Services.Features.Auth.Refresh;

public record RefreshTokenCommand(string AccessToken, string RefreshToken) : IRequest<Result<AuthResponse>>;