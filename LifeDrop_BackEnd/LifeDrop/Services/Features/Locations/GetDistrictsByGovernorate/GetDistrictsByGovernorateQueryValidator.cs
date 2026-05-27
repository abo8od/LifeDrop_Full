using FluentValidation;
using Services.Features.Locations.GetDistrictsByGovernorate;

namespace Services.Features.Locations.GetDistrictsByGovernorate;

public class GetDistrictsByGovernorateQueryValidator : AbstractValidator<GetDistrictsByGovernorateQuery>
{
    public GetDistrictsByGovernorateQueryValidator()
    {
        RuleFor(x => x.GovernorateId)
            .NotEmpty()
            .WithMessage("Governorate ID is required.");
    }
}