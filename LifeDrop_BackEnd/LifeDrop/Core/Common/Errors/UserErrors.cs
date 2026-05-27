using Core.Common;

namespace Core.Common.Errors;

public static class UserErrors
{
    public static readonly Error NotFound = new(
        "user.not_found",
        "The user was not found.",
        ErrorType.NotFound);

    public static readonly Error AlreadyExists = new(
        "user.already_exists",
        "A user with the same data already exists.",
        ErrorType.Conflict);

    public static readonly Error InactiveUser = new(
        "user.inactive",
        "The user account is inactive.",
        ErrorType.Unauthorized);

    public static readonly Error DuplicateEmail = new(
        "user.duplicate_email",
        "A user with this email already exists.",
        ErrorType.Conflict);

    public static readonly Error EmailNotFound = new(
        "user.email_not_found",
        "No user found with this email.",
        ErrorType.NotFound);

    public static readonly Error NotVerified = new(
        "user.not_verified",
        "Please verify your email before logging in.",
        ErrorType.Validation);
}