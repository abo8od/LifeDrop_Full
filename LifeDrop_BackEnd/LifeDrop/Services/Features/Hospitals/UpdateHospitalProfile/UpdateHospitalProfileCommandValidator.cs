using FluentValidation;

namespace Services.Features.Hospitals.UpdateHospitalProfile;

public class UpdateHospitalProfileCommandValidator : AbstractValidator<UpdateHospitalProfileCommand>
{
    public UpdateHospitalProfileCommandValidator()
    {
        RuleFor(x => x)
            .Must(x => !string.IsNullOrWhiteSpace(x.Name) || 
                       !string.IsNullOrWhiteSpace(x.Address) ||
                       !string.IsNullOrWhiteSpace(x.PhoneNumber) ||
                       x.Latitude.HasValue || 
                       x.Longitude.HasValue)
            .WithMessage("At least one field must be provided for update.");

        RuleFor(x => x.Name)
            .MaximumLength(200).WithMessage("Hospital name must not exceed 200 characters.")
            .When(x => !string.IsNullOrWhiteSpace(x.Name));

        RuleFor(x => x.Address)
            .MaximumLength(500).WithMessage("Hospital address must not exceed 500 characters.")
            .When(x => !string.IsNullOrWhiteSpace(x.Address));

        RuleFor(x => x.Latitude)
            .InclusiveBetween(-90, 90).WithMessage("Latitude must be between -90 and 90.")
            .When(x => x.Latitude.HasValue);

        RuleFor(x => x.Longitude)
            .InclusiveBetween(-180, 180).WithMessage("Longitude must be between -180 and 180.")
            .When(x => x.Longitude.HasValue);

        RuleFor(x => x.PhoneNumber)
            .Matches(@"^\+?[0-9]{10,15}$").WithMessage("Invalid phone number format.")
            .When(x => !string.IsNullOrWhiteSpace(x.PhoneNumber));
    }
}
