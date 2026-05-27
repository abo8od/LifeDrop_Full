using Core.Common;
using MediatR;
using Services.Features.Auth;

namespace Services.Features.Auth.Login;

public record LoginCommand(string Email, string Password) : IRequest<Result<AuthResponse>>;