using Core.Common;
using MediatR;

namespace Services.Features.Admin.Hospitals.CreateHospital;

public record CreateHospitalCommand(string Name, string Address, string PhoneNumber, double Latitude, double Longitude) : IRequest<Result<CreateHospitalResult>>;

public record CreateHospitalResult(Guid HospitalId, string Name);
