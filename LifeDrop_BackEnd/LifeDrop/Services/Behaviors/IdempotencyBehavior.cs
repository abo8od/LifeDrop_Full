using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;
using System.Reflection;

namespace Services.Behaviors;

public class IdempotencyBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IIdempotentCommand<TResponse>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<IdempotencyBehavior<TRequest, TResponse>> _logger;

    public IdempotencyBehavior(IUnitOfWork unitOfWork, ILogger<IdempotencyBehavior<TRequest, TResponse>> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        // 1. Try to insert the idempotency record FIRST (optimistic lock)
        // This prevents race conditions where two identical requests arrive simultaneously.
        try
        {
            await _unitOfWork.IdempotentRequests.AddAsync(new IdempotentRequest
            {
                Id = request.RequestId,
                Name = typeof(TRequest).Name,
                CreatedOn = DateTimeOffset.UtcNow
            });

            await _unitOfWork.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateException)
        {
            // Primary key violation = this RequestId was already processed
            _logger.LogWarning(
                "Duplicate request detected for RequestId: {RequestId}. Blocking handler execution.",
                request.RequestId);

            // Build a Result<T>.Failure(...) for the actual TResponse type via reflection,
            // because Result<object> cannot be cast to Result<AcceptDonationRequestResult>.
            var error = CommonErrors.ConcurrencyConflict;

            var failureMethod = typeof(TResponse).GetMethod(
                "Failure",
                BindingFlags.Public | BindingFlags.Static,
                [typeof(Error)]);

            if (failureMethod != null)
            {
                return (TResponse)failureMethod.Invoke(null, [error])!;
            }

            // Fallback: should never happen if TResponse is always Result<T>
            throw new InvalidOperationException(
                $"Cannot create a failure response for type {typeof(TResponse).Name}.");
        }

        // 2. Record inserted successfully — this is the first time. Execute the handler.
        return await next();
    }
}
