using Core.Common;
using FluentValidation;

namespace Services.Features.DonationRequests.CancelAcceptance;

public class CancelAcceptanceCommandValidator : AbstractValidator<CancelAcceptanceCommand>
{
    public CancelAcceptanceCommandValidator()
    {
        RuleFor(x => x.RequestId)
            .NotEmpty()
            .WithMessage("Request ID is required.");

        RuleFor(x => x.CancellationReasonId)
            .NotEmpty()
            .WithMessage("Cancellation reason is required.");

        RuleFor(x => x.Note)
            .MaximumLength(500)
            .When(x => x.Note != null)
            .WithMessage("Note cannot exceed 500 characters.");
    }
}