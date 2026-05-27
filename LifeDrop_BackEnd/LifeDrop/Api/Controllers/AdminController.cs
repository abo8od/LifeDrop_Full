using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.Admin.Hospitals.GetAllHospitals;
using Services.Features.Admin.Hospitals.GetHospitalEmployees;
using Services.Features.Admin.Hospitals.SetEmployeeActiveState;
using Services.Features.Admin.Hospitals.SetHospitalActiveState;
using Services.Features.Admin.SystemAdmin.GetGlobalOperations;
using Services.Features.Hospitals.GetHospitalEmployeeDetails;
using Services.Features.Hospitals.GetHospitalEmployees;
using Shared.Responses;
using Api.Common;

namespace Api.Controllers;

/// <summary>
/// API controller for system-wide administration operations.
/// Only accessible to system administrators.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[Authorize(Policy = "SystemAdminOnly")]
[Microsoft.AspNetCore.Http.Tags("System Administration")]
public class AdminController : BaseController
{
    private readonly IMediator _mediator;

    public AdminController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Get global operations stats.
    /// </summary>
    /// <remarks>
    /// Gets global system operations statistics and analytics. Only accessible to system administrators.
    /// </remarks>
    /// <returns>Global stats including total hospitals, donors, and requests by governorate.</returns>
    [HttpGet("operations", Name = nameof(GetGlobalOperations))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<GlobalOperationsDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetGlobalOperations()
    {
        var result = await _mediator.Send(new GetGlobalOperationsQuery());
        return HandleResult(result);
    }

    [HttpGet("hospitals", Name = nameof(GetAllHospitals))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<List<HospitalListItemDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetAllHospitals()
    {
        var result = await _mediator.Send(new GetAllHospitalsQuery());
        return HandleResult(result);
    }

    [HttpGet("hospitals/{hospitalId:guid}/employees", Name = nameof(GetHospitalEmployeesAdmin))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<List<HospitalEmployeeDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalEmployeesAdmin(Guid hospitalId)
    {
        var result = await _mediator.Send(new GetHospitalEmployeesAdminQuery(hospitalId));
        return HandleResult(result);
    }

    [HttpGet("hospitals/{hospitalId:guid}/employees/{employeeProfileId:guid}", Name = nameof(GetHospitalEmployeeDetailsAdmin))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<HospitalEmployeeDetailsDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalEmployeeDetailsAdmin(Guid hospitalId, Guid employeeProfileId)
    {
        var result = await _mediator.Send(new GetHospitalEmployeeDetailsQuery(hospitalId, employeeProfileId));
        return HandleResult(result);
    }

    [HttpPatch("hospitals/employees/{employeeProfileId:guid}/activate", Name = nameof(ActivateEmployee))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<SetEmployeeActiveStateResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> ActivateEmployee(Guid employeeProfileId)
    {
        var result = await _mediator.Send(new SetEmployeeActiveStateCommand(employeeProfileId, IsActive: true));
        return HandleResult(result);
    }

    [HttpPatch("hospitals/employees/{employeeProfileId:guid}/deactivate", Name = nameof(DeactivateEmployee))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<SetEmployeeActiveStateResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> DeactivateEmployee(Guid employeeProfileId)
    {
        var result = await _mediator.Send(new SetEmployeeActiveStateCommand(employeeProfileId, IsActive: false));
        return HandleResult(result);
    }

    [HttpPatch("hospitals/{hospitalId:guid}/activate", Name = nameof(ActivateHospital))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<SetHospitalActiveStateResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> ActivateHospital(Guid hospitalId)
    {
        var result = await _mediator.Send(new SetHospitalActiveStateCommand(hospitalId, IsActive: true));
        return HandleResult(result);
    }

    [HttpPatch("hospitals/{hospitalId:guid}/deactivate", Name = nameof(DeactivateHospital))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<SetHospitalActiveStateResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> DeactivateHospital(Guid hospitalId)
    {
        var result = await _mediator.Send(new SetHospitalActiveStateCommand(hospitalId, IsActive: false));
        return HandleResult(result);
    }
}
