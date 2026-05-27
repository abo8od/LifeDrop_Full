using Core.Enums;
using FluentValidation;
using Services.Features.DonationRequests.CreateDonationRequest;

namespace Services.Features.DonationRequests.CreateDonationRequest;

public class CreateDonationRequestCommandValidator : AbstractValidator<CreateDonationRequestCommand>
{
    public CreateDonationRequestCommandValidator()
    {
        RuleFor(x => x.HospitalId)
            .NotEmpty()
            .WithMessage("Hospital ID is required.");

        RuleFor(x => x.TargetQuota)
            .GreaterThan(0)
            .WithMessage("Target quota must be greater than 0.");

        RuleFor(x => x.TargetDistrictIds)
            .NotNull()
            .WithMessage("Target districts are required.")
            .Must(x => x.Count > 0)
            .WithMessage("At least one target district must be selected.");

        RuleFor(x => x.BloodType)
            .IsInEnum()
            .WithMessage("Invalid blood type.");

        RuleFor(x => x.Urgency)
            .IsInEnum()
            .WithMessage("Invalid urgency level.");

        RuleFor(x => x.ExpiryDate)
            .GreaterThan(DateTime.UtcNow)
            .When(x => x.ExpiryDate.HasValue)
            .WithMessage("Expiry date must be in the future.")
            // Ensure UTC for PostgreSQL compatibility
            .Must(x => x?.Kind == DateTimeKind.Utc || x?.Kind == DateTimeKind.Unspecified)
            .When(x => x.ExpiryDate.HasValue)
            .WithMessage("Expiry date must be in UTC format.");
    }
}