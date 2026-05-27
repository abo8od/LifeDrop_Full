using Core.Common;

namespace Core.Common.Errors;

public static class OtpErrors
{
    public static readonly Error InvalidCode = new(
        "otp.invalid_code",
        "Invalid OTP code.",
        ErrorType.Validation);

    public static readonly Error Expired = new(
        "otp.expired",
        "The OTP code has expired.",
        ErrorType.Validation);

    public static readonly Error RegistrationNotFound = new(
        "otp.registration_not_found",
        "Pending registration not found or expired.",
        ErrorType.NotFound);

    public static readonly Error EmailSendFailed = new(
        "otp.email_send_failed",
        "Failed to send the OTP email. Please try again.",
        ErrorType.Failure);
}
