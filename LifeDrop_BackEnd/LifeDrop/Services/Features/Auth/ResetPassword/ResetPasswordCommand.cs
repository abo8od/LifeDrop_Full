using Core.Common;
using MediatR;

namespace Services.Features.Auth.ResetPassword;

public record ResetPasswordCommand(string Email, string Code, string NewPassword) : IRequest<Result>;
