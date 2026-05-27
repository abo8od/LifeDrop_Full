using Core.Common;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;

namespace Services.Features.Admin.Hospitals.GetAllHospitals;

public class GetAllHospitalsQueryHandler : IRequestHandler<GetAllHospitalsQuery, Result<List<HospitalListItemDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<GetAllHospitalsQueryHandler> _logger;

    public GetAllHospitalsQueryHandler(IUnitOfWork unitOfWork, ILogger<GetAllHospitalsQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<Result<List<HospitalListItemDto>>> Handle(
        GetAllHospitalsQuery request,
        CancellationToken cancellationToken)
    {
        var hospitals = await _unitOfWork.Hospitals
            .Query()
            .AsNoTracking()
            .OrderBy(h => h.Name)
            .Select(h => new HospitalListItemDto(
                h.Id,
                h.Name,
                h.Address,
                h.Latitude,
                h.Longitude,
                h.IsVerified,
                h.CreatedOn,
                h.Employees.Count(e => e.User.Role == Role.HospitalAdmin && e.User.IsActive),
                h.Employees.Count(e => e.User.Role == Role.HospitalEmployee && e.User.IsActive)
            ))
            .ToListAsync(cancellationToken);

        _logger.LogInformation("Admin fetched all hospitals. Count: {Count}.", hospitals.Count);

        return Result<List<HospitalListItemDto>>.Success(hospitals);
    }
}
