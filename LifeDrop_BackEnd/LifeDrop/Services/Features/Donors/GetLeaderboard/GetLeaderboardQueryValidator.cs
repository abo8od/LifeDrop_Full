using FluentValidation;
using Services.Features.Donors.GetLeaderboard;

namespace Services.Features.Donors.GetLeaderboard;

public class GetLeaderboardQueryValidator : AbstractValidator<GetLeaderboardQuery>
{
    private const int MaxTopN = 100;

    public GetLeaderboardQueryValidator()
    {
        RuleFor(x => x.TopN)
            .InclusiveBetween(1, MaxTopN)
            .WithMessage($"TopN must be between 1 and {MaxTopN}.");

        RuleFor(x => x.GovernorateId)
            .Must(id => !id.HasValue || id != Guid.Empty)
            .When(x => x.GovernorateId.HasValue)
            .WithMessage("GovernorateId must be a valid GUID.");
    }
}