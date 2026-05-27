using Core.Common;
using MediatR;
using Services.Interfaces;

namespace Services.Features.Hospitals.GetHospitalEmployeeDetails;

public record GetHospitalEmployeeDetailsQuery(Guid HospitalId, Guid EmployeeProfileId) : ICachedQuery<Result<HospitalEmployeeDetailsDto>>
{
    public string CacheKey => $"employee:{EmployeeProfileId}:hospital:{HospitalId}";
    public string[] Tags => [$"employees_hospital_{HospitalId}"];
    public TimeSpan Expiration => TimeSpan.FromMinutes(10);
}
