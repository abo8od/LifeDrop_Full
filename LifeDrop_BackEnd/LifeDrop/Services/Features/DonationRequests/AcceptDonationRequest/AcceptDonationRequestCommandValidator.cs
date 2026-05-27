using FluentValidation;
using Services.Features.DonationRequests.AcceptDonationRequest;

namespace Services.Features.DonationRequests.AcceptDonationRequest;

public class AcceptDonationRequestCommandValidator : AbstractValidator<AcceptDonationRequestCommand>
{
    public AcceptDonationRequestCommandValidator()
    {
        RuleFor(x => x.DonationRequestId)
            .NotEmpty()
            .WithMessage("Donation request ID is required.");
    }
}