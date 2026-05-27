using Core.Common;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.Locations.Dtos;

namespace Services.Features.Locations.GetGovernorates;

public class GetGovernoratesQueryHandler : IRequestHandler<GetGovernoratesQuery, Result<List<LocationDto>>>
{
    private readonly IUnitOfWork _unitOfWork;

    public GetGovernoratesQueryHandler(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<List<LocationDto>>> Handle(GetGovernoratesQuery request, CancellationToken cancellationToken)
    {
        var governorates = await _unitOfWork.Governorates
            .Query()
            .AsNoTracking()
            .Select(g => new LocationDto(g.Id, g.NameAr, g.NameAr, g.NameEn))
            .ToListAsync(cancellationToken);

        return Result<List<LocationDto>>.Success(governorates);
    }
}