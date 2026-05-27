using FluentValidation;

namespace Services.Features.Donors.VerifyRegistration;

public class VerifyRegistrationValidator : AbstractValidator<VerifyRegistrationCommand>
{
    public VerifyRegistrationValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("Invalid email format.");

        RuleFor(x => x.Code)
            .NotEmpty().WithMessage("OTP code is required.")
            .Length(6).WithMessage("OTP code must be exactly 6 digits.")
            .Matches("^[0-9]+$").WithMessage("OTP code must contain only numbers.");
    }
}
