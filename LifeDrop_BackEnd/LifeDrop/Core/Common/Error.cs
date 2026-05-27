namespace Core.Common;

public sealed record Error(string Code, string Description, ErrorType Type)
{
    public static readonly Error None = new(string.Empty, string.Empty, ErrorType.Failure);

    public static readonly Error NullValue = new(
        "general.null_value",
        "A null value was provided where one is not allowed.",
        ErrorType.Validation);

    public static readonly Error ConditionNotMet = new(
        "general.condition_not_met",
        "A condition was not met for the operation to proceed.",
        ErrorType.Failure);

    public Dictionary<string, List<string>>? ValidationErrors { get; init; }

    public static Error ValidationError(Dictionary<string, List<string>> validationErrors) => new(
        "validation.failed",
        "One or more validation errors occurred.",
        ErrorType.Validation)
    {
        ValidationErrors = validationErrors
    };
}