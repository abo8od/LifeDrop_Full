using Core.Common;
using MediatR;
using Services.Features.Hospitals.GetHospitalEmployees;

namespace Services.Features.Admin.Hospitals.GetHospitalEmployees;

public record GetHospitalEmployeesAdminQuery(Guid HospitalId) : IRequest<Result<List<HospitalEmployeeDto>>>;
