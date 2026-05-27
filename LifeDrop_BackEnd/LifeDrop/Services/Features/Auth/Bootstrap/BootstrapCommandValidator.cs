using FluentValidation;
using Services.Features.Auth.Bootstrap;

namespace Services.Features.Auth.Bootstrap;

public class BootstrapCommandValidator : AbstractValidator<BootstrapCommand>
{
    public BootstrapCommandValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("Invalid email format.");

        RuleFor(x => x.Password)
            .NotEmpty().WithMessage("Password is required.")
            .MinimumLength(8).WithMessage("Password must be at least 8 characters.");

        RuleFor(x => x.BootstrapSecret)
            .NotEmpty().WithMessage("Bootstrap secret is required.");
    }
}