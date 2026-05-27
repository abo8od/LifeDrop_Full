using FluentValidation;
using Services.Features.Admin.Hospitals.CreateHospitalEmployee;

namespace Services.Features.Admin.Hospitals.CreateHospitalEmployee;

public class CreateHospitalEmployeeValidator : AbstractValidator<CreateHospitalEmployeeCommand>
{
    public CreateHospitalEmployeeValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("Invalid email format.");

        RuleFor(x => x.Password)
            .NotEmpty().WithMessage("Password is required.")
            .MinimumLength(8).WithMessage("Password must be at least 8 characters.");

        RuleFor(x => x.FirstName)
            .NotEmpty().WithMessage("First name is required.")
            .MaximumLength(100).WithMessage("First name must not exceed 100 characters.");

        RuleFor(x => x.LastName)
            .NotEmpty().WithMessage("Last name is required.")
            .MaximumLength(100).WithMessage("Last name must not exceed 100 characters.");

        RuleFor(x => x.HospitalId)
            .NotEmpty().WithMessage("Hospital ID is required.");
    }
}