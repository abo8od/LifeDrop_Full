using FluentValidation;

namespace Services.Features.Donors.VerifyDonorMedicalInfo;

public class VerifyDonorMedicalInfoCommandValidator : AbstractValidator<VerifyDonorMedicalInfoCommand>
{
    public VerifyDonorMedicalInfoCommandValidator()
    {
        RuleFor(x => x.DonorUserId)
            .NotEmpty()
            .WithMessage("Donor User ID is required.");
    }
}