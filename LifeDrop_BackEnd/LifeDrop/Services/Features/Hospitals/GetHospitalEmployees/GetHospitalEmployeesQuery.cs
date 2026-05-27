using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Shared.Requests;
using Shared.Responses;
using System.Text.Json.Serialization;

namespace Services.Features.Hospitals.GetHospitalEmployees;

public class GetHospitalEmployeesQuery : PagedRequest, IRequest<Result<PagedResponse<HospitalEmployeeDto>>>
{
    [JsonIgnore]
    [BindNever]
    public Guid HospitalId { get; set; }
}
