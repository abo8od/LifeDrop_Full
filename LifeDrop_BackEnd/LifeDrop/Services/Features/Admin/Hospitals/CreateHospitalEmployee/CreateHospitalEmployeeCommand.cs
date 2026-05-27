using Core.Common;
using MediatR;

namespace Services.Features.Admin.Hospitals.CreateHospitalEmployee;

public record CreateHospitalEmployeeCommand(
    string Email,
    string Password,
    string FirstName,
    string LastName,
    Guid HospitalId
) : IRequest<Result<CreateHospitalEmployeeResult>>;

public record CreateHospitalEmployeeResult(Guid UserId, string Email, Guid HospitalId);
