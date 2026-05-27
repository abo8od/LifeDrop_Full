using Core.Common;
using MediatR;

namespace Services.Features.Admin.Hospitals.GetAllHospitals;

public record GetAllHospitalsQuery : IRequest<Result<List<HospitalListItemDto>>>;

public record HospitalListItemDto(
    Guid HospitalId,
    string Name,
    string Address,
    double Latitude,
    double Longitude,
    bool IsActive,
    DateTimeOffset CreatedOn,
    int AdminCount,
    int EmployeeCount
);
