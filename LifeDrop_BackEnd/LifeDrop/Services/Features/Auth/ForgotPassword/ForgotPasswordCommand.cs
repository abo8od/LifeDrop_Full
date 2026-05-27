using Core.Common;
using MediatR;

namespace Services.Features.Auth.ForgotPassword;

public record ForgotPasswordCommand(string Email) : IRequest<Result>;
