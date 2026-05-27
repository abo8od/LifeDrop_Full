using FluentValidation;

namespace Services.Features.Auth.ResendResetPasswordOtp;

public class ResendResetPasswordOtpCommandValidator : AbstractValidator<ResendResetPasswordOtpCommand>
{
    public ResendResetPasswordOtpCommandValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("A valid email address is required.");
    }
}
