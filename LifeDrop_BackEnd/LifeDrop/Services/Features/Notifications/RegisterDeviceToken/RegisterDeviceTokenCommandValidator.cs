using FluentValidation;

namespace Services.Features.Notifications.RegisterDeviceToken;

public class RegisterDeviceTokenCommandValidator : AbstractValidator<RegisterDeviceTokenCommand>
{
    public RegisterDeviceTokenCommandValidator()
    {
        RuleFor(x => x.Token)
            .NotEmpty().WithMessage("Device token is required.")
            .MaximumLength(512).WithMessage("Device token must not exceed 512 characters.");

        RuleFor(x => x.Platform)
            .IsInEnum().WithMessage("Invalid device platform.");
    }
}
