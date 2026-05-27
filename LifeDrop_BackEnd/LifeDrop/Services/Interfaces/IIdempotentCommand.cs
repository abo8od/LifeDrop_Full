using MediatR;

namespace Services.Interfaces;

public interface IIdempotentCommand<out TResponse> : IRequest<TResponse>
{
    Guid RequestId { get; }
}
