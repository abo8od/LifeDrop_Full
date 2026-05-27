using FluentValidation;
using Services.Features.Donors.UpdateDonorProfile;

namespace Services.Features.Donors.UpdateDonorProfile;

public class UpdateDonorProfileCommandValidator : AbstractValidator<UpdateDonorProfileCommand>
{
    public UpdateDonorProfileCommandValidator()
    {
        RuleFor(x => x)
            .Must(x => !string.IsNullOrWhiteSpace(x.FirstName) || 
                       !string.IsNullOrWhiteSpace(x.LastName) || 
                       !string.IsNullOrWhiteSpace(x.PhoneNumber) || 
                       !string.IsNullOrWhiteSpace(x.BloodType) ||
                       x.IsAvailable.HasValue || 
                       x.GovernorateId.HasValue || 
                       x.DistrictId.HasValue ||
                       x.ReceiveCriticalNotifications.HasValue ||
                       x.ReceiveUrgentNotifications.HasValue ||
                       x.ReceiveNormalNotifications.HasValue)
            .WithMessage("At least one field must be provided for update.");

        RuleFor(x => x.FirstName)
            .MaximumLength(50).WithMessage("First name must not exceed 50 characters.")
            .When(x => !string.IsNullOrWhiteSpace(x.FirstName));

        RuleFor(x => x.LastName)
            .MaximumLength(50).WithMessage("Last name must not exceed 50 characters.")
            .When(x => !string.IsNullOrWhiteSpace(x.LastName));

        RuleFor(x => x.PhoneNumber)
            .Matches(@"^\+962[789]\d{8}$")
            .WithMessage("Phone number must start with +962 followed by 9 digits.")
            .When(x => !string.IsNullOrWhiteSpace(x.PhoneNumber));

        RuleFor(x => x.BloodType)
            .NotEmpty()
            .When(x => x.BloodType != null)
            .WithMessage("Blood type cannot be empty if provided.");

        RuleFor(x => x.GovernorateId)
            .NotEmpty()
            .When(x => x.GovernorateId.HasValue)
            .WithMessage("A valid governorate ID is required.");

        RuleFor(x => x.DistrictId)
            .NotEmpty()
            .When(x => x.DistrictId.HasValue)
            .WithMessage("A valid district ID is required.");
    }
}
