using FluentValidation;

namespace Services.Features.Notifications.UnregisterDeviceToken;

public class UnregisterDeviceTokenCommandValidator : AbstractValidator<UnregisterDeviceTokenCommand>
{
    public UnregisterDeviceTokenCommandValidator()
    {
        RuleFor(x => x.Token)
            .NotEmpty().WithMessage("Device token is required.")
            .MaximumLength(512).WithMessage("Device token must not exceed 512 characters.");
    }
}
