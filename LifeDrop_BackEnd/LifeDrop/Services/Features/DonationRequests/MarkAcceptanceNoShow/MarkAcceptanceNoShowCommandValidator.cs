using FluentValidation;

namespace Services.Features.DonationRequests.MarkAcceptanceNoShow;

public class MarkAcceptanceNoShowCommandValidator : AbstractValidator<MarkAcceptanceNoShowCommand>
{
    public MarkAcceptanceNoShowCommandValidator()
    {
        RuleFor(x => x.AcceptanceId)
            .NotEmpty().WithMessage("Acceptance ID is required.");
    }
}
