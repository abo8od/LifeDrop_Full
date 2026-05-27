using Core.Common;
using MediatR;

namespace Services.Features.Admin.Hospitals.CreateHospitalAdmin;

public record CreateHospitalAdminCommand(
    string Email,
    string Password,
    string FirstName,
    string LastName,
    Guid HospitalId
) : IRequest<Result<CreateHospitalAdminResult>>;

public record CreateHospitalAdminResult(Guid UserId, string Email, Guid HospitalId);
