using Core.Common;
using MediatR;
using Services.Interfaces;

namespace Services.Features.Donors.VerifyRegistration;

public record VerifyRegistrationCommand(string Email, string Code) : IRequest<Result<VerifyRegistrationResult>>;

public record VerifyRegistrationResult(string Email, string Token, string RefreshToken);
