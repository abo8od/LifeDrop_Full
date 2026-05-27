using Core.Common;
using MediatR;

namespace Services.Features.Auth.Bootstrap;

public record BootstrapCommand(string Email, string Password, string BootstrapSecret) : IRequest<Result<BootstrapResult>>;

public record BootstrapResult(string Message);
