using FluentValidation;
using Core.Enums;
using Services.Features.Donors.RegisterDonor;

namespace Services.Features.Donors.RegisterDonor;

public class RegisterDonorCommandValidator : AbstractValidator<RegisterDonorCommand>
{
    public RegisterDonorCommandValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("Invalid email format.");

        RuleFor(x => x.Password)
            .NotEmpty().WithMessage("Password is required.")
            .MinimumLength(8).WithMessage("Password must be at least 8 characters.");

        RuleFor(x => x.ConfirmPassword)
            .NotEmpty().WithMessage("Confirm password is required.")
            .Equal(x => x.Password).WithMessage("Passwords do not match.");

        RuleFor(x => x.FirstName)
            .NotEmpty().WithMessage("First name is required.")
            .MaximumLength(100).WithMessage("First name must not exceed 100 characters.");

        RuleFor(x => x.LastName)
            .NotEmpty().WithMessage("Last name is required.")
            .MaximumLength(100).WithMessage("Last name must not exceed 100 characters.");

        RuleFor(x => x.DateOfBirth)
            .NotEmpty().WithMessage("Date of birth is required.")
            .LessThan(DateTime.Now).WithMessage("Date of birth must be in the past.");

        RuleFor(x => x.BloodType)
            .NotEmpty().WithMessage("Blood type is required.")
            .IsEnumName(typeof(Core.Enums.BloodType), caseSensitive: false)
            .WithMessage("Invalid blood type. Accepted values are: O_Positive, O_Negative, A_Positive, A_Negative, B_Positive, B_Negative, AB_Positive, AB_Negative");

        RuleFor(x => x.PhoneNumber)
            .NotEmpty().WithMessage("Phone number is required.")
            .Matches(@"^\+962[789]\d{8}$").WithMessage("Phone number must start with +962 followed by 9 digits.");
    }
}