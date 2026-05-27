using Core.Common;

namespace Core.Common.Errors;

public static class CommonErrors
{
    public static readonly Error InvalidInput = new(
        "common.invalid_input",
        "The provided input is invalid.",
        ErrorType.Validation);

    public static readonly Error ServerError = new(
        "common.server_error",
        "An unexpected error occurred.",
        ErrorType.Failure);

    public static readonly Error ConcurrencyConflict = new(
        "common.concurrency_conflict",
        "A concurrent request was detected. Please wait and try again.",
        ErrorType.Conflict);
}