using Core.Common;
using Core.Enums;
using MediatR;
using Services.Features.ReferenceData.Dtos;

namespace Services.Features.ReferenceData.GetBloodTypes;

public class GetBloodTypesQueryHandler : IRequestHandler<GetBloodTypesQuery, Result<List<BloodTypeDto>>>
{
    public Task<Result<List<BloodTypeDto>>> Handle(GetBloodTypesQuery request, CancellationToken cancellationToken)
    {
        var bloodTypes = Enum.GetValues<BloodType>()
            .Select(bt => new BloodTypeDto(
                Value: bt.ToString(),
                DisplayName: bt.ToString()
                    .Replace("_Positive", "+")
                    .Replace("_Negative", "-")
            ))
            .ToList();

        return Task.FromResult(Result<List<BloodTypeDto>>.Success(bloodTypes));
    }
}