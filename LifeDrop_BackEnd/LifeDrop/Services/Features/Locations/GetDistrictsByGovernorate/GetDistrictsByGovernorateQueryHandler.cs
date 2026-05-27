using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.Locations.Dtos;
using Microsoft.Extensions.Logging;

namespace Services.Features.Locations.GetDistrictsByGovernorate;

public class GetDistrictsByGovernorateQueryHandler : IRequestHandler<GetDistrictsByGovernorateQuery, Result<List<LocationDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<GetDistrictsByGovernorateQueryHandler> _logger;

    public GetDistrictsByGovernorateQueryHandler(IUnitOfWork unitOfWork, ILogger<GetDistrictsByGovernorateQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<Result<List<LocationDto>>> Handle(GetDistrictsByGovernorateQuery request, CancellationToken cancellationToken)
    {
        var governorateExists = await _unitOfWork.Governorates
            .Query()
            .AsNoTracking()
            .AnyAsync(g => g.Id == request.GovernorateId, cancellationToken);

        if (!governorateExists)
        {
            _logger.LogWarning("Get districts failed: governorate {GovernorateId} not found.", request.GovernorateId);
            return Result<List<LocationDto>>.Failure(LocationErrors.GovernorateNotFound);
        }

        var districts = await _unitOfWork.Districts
            .Query()
            .AsNoTracking()
            .Where(d => d.GovernorateId == request.GovernorateId)
            .Select(d => new LocationDto(d.Id, d.NameAr, d.NameAr, d.NameEn))
            .ToListAsync(cancellationToken);

        return Result<List<LocationDto>>.Success(districts);
    }
}