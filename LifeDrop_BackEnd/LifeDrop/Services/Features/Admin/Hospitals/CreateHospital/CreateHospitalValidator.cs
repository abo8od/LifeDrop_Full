using FluentValidation;
using Services.Features.Admin.Hospitals.CreateHospital;

namespace Services.Features.Admin.Hospitals.CreateHospital;

public class CreateHospitalValidator : AbstractValidator<CreateHospitalCommand>
{
    public CreateHospitalValidator()
    {
        RuleFor(x => x.Name)
            .NotEmpty().WithMessage("Hospital name is required.")
            .MaximumLength(200).WithMessage("Hospital name must not exceed 200 characters.");

        RuleFor(x => x.Address)
            .NotEmpty().WithMessage("Hospital address is required.")
            .MaximumLength(500).WithMessage("Hospital address must not exceed 500 characters.");

        RuleFor(x => x.PhoneNumber)
            .NotEmpty().WithMessage("Hospital phone number is required.")
            .Matches(@"^\+?[0-9]{10,15}$").WithMessage("Invalid phone number format.");

        RuleFor(x => x.Latitude)
            .InclusiveBetween(-90, 90).WithMessage("Latitude must be between -90 and 90.");

        RuleFor(x => x.Longitude)
            .InclusiveBetween(-180, 180).WithMessage("Longitude must be between -180 and 180.");
    }
}