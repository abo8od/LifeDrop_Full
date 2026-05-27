using FluentValidation;

namespace Services.Features.DonationRequests.FulfillAcceptance;

public class FulfillAcceptanceCommandValidator : AbstractValidator<FulfillAcceptanceCommand>
{
    public FulfillAcceptanceCommandValidator()
    {
        RuleFor(x => x.AcceptanceId)
            .NotEmpty().WithMessage("Acceptance ID is required.");
    }
}
