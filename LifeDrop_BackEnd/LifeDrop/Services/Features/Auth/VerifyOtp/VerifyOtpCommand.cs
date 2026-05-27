using Core.Common;
using MediatR;

namespace Services.Features.Auth.VerifyOtp;

public record VerifyOtpCommand(string Email, string Code) : IRequest<Result>;
