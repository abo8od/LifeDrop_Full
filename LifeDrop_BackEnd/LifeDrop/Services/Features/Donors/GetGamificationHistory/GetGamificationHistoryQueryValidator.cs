using FluentValidation;

namespace Services.Features.Donors.GetGamificationHistory;

public class GetGamificationHistoryQueryValidator : AbstractValidator<GetGamificationHistoryQuery>
{
    public GetGamificationHistoryQueryValidator()
    {
        RuleFor(x => x.PageNumber)
            .GreaterThan(0).WithMessage("Page number must be greater than 0.");

        RuleFor(x => x.PageSize)
            .GreaterThan(0).WithMessage("Page size must be greater than 0.")
            .LessThanOrEqualTo(100).WithMessage("Page size must not exceed 100.");
    }
}
