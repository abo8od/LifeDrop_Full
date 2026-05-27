using Core.Common;
using MediatR;

namespace Services.Features.Hospitals.UpdateHospitalProfile;

public record UpdateHospitalProfileCommand(
    string? Name,
    string? Address,
    string? PhoneNumber,
    double? Latitude,
    double? Longitude
) : IRequest<Result<UpdateHospitalProfileResult>>;

public record UpdateHospitalProfileResult(
    Guid HospitalId,
    string Name,
    string Address,
    string PhoneNumber,
    double Latitude,
    double Longitude
);
