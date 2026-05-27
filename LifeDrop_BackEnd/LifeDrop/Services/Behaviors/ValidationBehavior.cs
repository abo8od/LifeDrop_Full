using Core.Common;
using FluentValidation;
using MediatR;
using System.Reflection;

namespace Services.Behaviors;

public class ValidationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : class, IRequest<TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;

    public ValidationBehavior(IEnumerable<IValidator<TRequest>> validators)
    {
        _validators = validators;
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        if (!_validators.Any())
            return await next();

        var context = new ValidationContext<TRequest>(request);

        var validationResults =
            await Task.WhenAll(_validators.Select(v => v.ValidateAsync(context, cancellationToken)));
        var failures = validationResults.Where(r => r.Errors.Count != 0).SelectMany(r => r.Errors).ToList();

        if (failures.Count != 0)
        {
            var errors = failures
                .GroupBy(e => e.PropertyName, e => e.ErrorMessage)
                .ToDictionary(failureGroup => failureGroup.Key, failureGroup => failureGroup.ToList());

            var validationError = Error.ValidationError(errors);

            return CreateFailure(validationError);
        }

        return await next();
    }

    private TResponse CreateFailure(Error error)
    {
        var responseType = typeof(TResponse);
        
        if (responseType == typeof(Result))
            return (TResponse)(object)Result.Failure(error);

        if (responseType.IsGenericType && responseType.GetGenericTypeDefinition() == typeof(Result<>))
        {
            var factory = typeof(ResultFactory<>).MakeGenericType(responseType.GetGenericArguments()[0]);
            var method = factory.GetMethod("Failure", [typeof(Error)]);
            return (TResponse)method!.Invoke(null, [error])!;
        }

        return (TResponse)(object)Result.Failure(error);
    }
}

internal static class ResultFactory<T>
{
    public static Result<T> Failure(Error error) => Result<T>.Failure(error);
}