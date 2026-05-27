using FluentValidation;

namespace Services.Features.Donors.ResendRegistrationOtp;

public class ResendRegistrationOtpCommandValidator : AbstractValidator<ResendRegistrationOtpCommand>
{
    public ResendRegistrationOtpCommandValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("A valid email address is required.");
    }
}
