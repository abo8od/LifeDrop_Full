using Core.Common;

namespace Core.Common.Errors;

public static class AuthenticationErrors
{
    public static readonly Error InvalidCredentials = new(
        "auth.invalid_credentials",
        "The email or password is incorrect. Please check your credentials or reset your password.",
        ErrorType.Unauthorized);

    public static readonly Error InvalidToken = new(
        "auth.invalid_token",
        "The provided token is invalid.",
        ErrorType.Unauthorized);

    public static readonly Error ExpiredToken = new(
        "auth.expired_token",
        "The provided token has expired.",
        ErrorType.Unauthorized);

    public static readonly Error TokenAlreadyUsed = new(
        "auth.token_already_used",
        "The token has already been used.",
        ErrorType.Unauthorized);

    public static readonly Error TokenRevoked = new(
        "auth.token_revoked",
        "The token has been revoked.",
        ErrorType.Unauthorized);

    public static readonly Error SamePasswordAsOld = new(
        "auth.same_password_as_old",
        "The new password cannot be the same as your current password.",
        ErrorType.Validation);

    public static readonly Error BootstrapInvalidSecret = new(
        "auth.bootstrap_invalid_secret",
        "Invalid bootstrap secret.",
        ErrorType.Unauthorized);

    public static readonly Error BootstrapAlreadyExists = new(
        "auth.bootstrap_already_exists",
        "System admin already exists.",
        ErrorType.Conflict);
}