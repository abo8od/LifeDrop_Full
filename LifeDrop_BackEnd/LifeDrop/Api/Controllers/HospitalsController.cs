using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.Admin.Hospitals.CreateHospital;
using Services.Features.Admin.Hospitals.CreateHospitalAdmin;
using Services.Features.Admin.Hospitals.CreateHospitalEmployee;
using Services.Features.Hospitals.GetHospitalProfile;
using Services.Features.Hospitals.GetDashboardOverview;
using Services.Features.Hospitals.GetHospitalAnalytics;
using Services.Features.Hospitals.GetDonorCommunication;
using Services.Features.Hospitals.GetHospitalEmployees;
using Services.Features.Hospitals.GetHospitalEmployeeDetails;
using Services.Features.Hospitals.UpdateHospitalProfile;
using Shared.Responses;
using Api.Common;
using Services.Interfaces;

namespace Api.Controllers;

/// <summary>
/// API controller for hospital management operations.
/// Handles creation of hospitals, hospital admins, and hospital employees.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[Authorize]
[Microsoft.AspNetCore.Http.Tags("Hospitals")]
public class HospitalsController : BaseController
{
    private readonly IMediator _mediator;
    private readonly ICurrentUserService _currentUserService;

    public HospitalsController(IMediator mediator, ICurrentUserService currentUserService)
    {
        _mediator = mediator;
        _currentUserService = currentUserService;
    }

    [HttpPost(Name = nameof(CreateHospital))]
    [Authorize(Policy = "SystemAdminOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CreateHospitalResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> CreateHospital([FromBody] CreateHospitalCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Creates a hospital admin account for an existing hospital.
    /// Only accessible to system administrators.
    /// </summary>
    /// <param name="command">The admin creation command containing hospital ID and admin credentials.</param>
    /// <returns>Created admin user information.</returns>
    [HttpPost("admin", Name = nameof(CreateHospitalAdmin))]
    [Authorize(Policy = "SystemAdminOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CreateHospitalAdminResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> CreateHospitalAdmin([FromBody] CreateHospitalAdminCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Creates a hospital employee account for an existing hospital.
    /// Only accessible to hospital administrators.
    /// </summary>
    /// <param name="command">The employee creation command containing hospital ID and employee credentials.</param>
    /// <returns>Created employee user information.</returns>
    [HttpPost("employee", Name = nameof(CreateHospitalEmployee))]
    [Authorize(Policy = "HospitalAdminOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CreateHospitalEmployeeResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> CreateHospitalEmployee([FromBody] CreateHospitalEmployeeCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Get hospital profile.
    /// </summary>
    /// <remarks>
    /// Gets the current hospital's profile and statistics.
    /// Only accessible to hospital employees.
    /// </remarks>
    /// <returns>Hospital profile with statistics.</returns>
    [HttpGet("me", Name = nameof(GetHospitalProfile))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<HospitalProfileDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalProfile()
    {
        if (_currentUserService.HospitalId is not { } hospitalId) return Unauthorized();
        var result = await _mediator.Send(new GetHospitalProfileQuery(hospitalId));
        return HandleResult(result);
    }

    /// <summary>
    /// Get dashboard overview.
    /// </summary>
    /// <remarks>
    /// Gets the hospital dashboard overview statistics.
    /// Only accessible to hospital employees.
    /// </remarks>
    /// <returns>Dashboard overview statistics and recent activities.</returns>
    [HttpGet("dashboard/overview", Name = nameof(GetDashboardOverview))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<DashboardOverviewDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDashboardOverview()
    {
        if (_currentUserService.HospitalId is not { } hospitalId) return Unauthorized();
        var result = await _mediator.Send(new GetDashboardOverviewQuery { HospitalId = hospitalId });
        return HandleResult(result);
    }

    /// <summary>
    /// Get hospital analytics.
    /// </summary>
    /// <remarks>
    /// Gets the hospital analytics and reports data.
    /// Only accessible to hospital employees.
    /// </remarks>
    /// <returns>Analytics data including blood type distribution and monthly stats.</returns>
    [HttpGet("analytics", Name = nameof(GetHospitalAnalytics))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<HospitalAnalyticsDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalAnalytics()
    {
        if (_currentUserService.HospitalId is not { } hospitalId) return Unauthorized();
        var result = await _mediator.Send(new GetHospitalAnalyticsQuery { HospitalId = hospitalId });
        return HandleResult(result);
    }

    /// <summary>
    /// Get donor communication list.
    /// </summary>
    /// <remarks>
    /// Gets the list of donors who have interacted with this hospital for communication purposes.
    /// Only accessible to hospital employees.
    /// </remarks>
    /// <param name="query">Pagination parameters.</param>
    /// <returns>Paged list of donor interactions with the hospital.</returns>
    [HttpGet("donors/communication", Name = nameof(GetDonorCommunication))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<DonorInteractionDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonorCommunication([FromQuery] GetDonorCommunicationQuery query)
    {
        if (_currentUserService.HospitalId is not { } hospitalId) return Unauthorized();
        query.HospitalId = hospitalId;
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Update hospital profile.
    /// </summary>
    /// <remarks>
    /// Updates the hospital profile details.
    /// Only accessible to hospital administrators.
    /// </remarks>
    /// <param name="command">The update details.</param>
    /// <returns>The updated hospital profile.</returns>
    [HttpPut("profile", Name = nameof(UpdateHospitalProfile))]
    [Authorize(Policy = "HospitalAdminOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<UpdateHospitalProfileResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> UpdateHospitalProfile([FromBody] UpdateHospitalProfileCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Get hospital employees.
    /// </summary>
    /// <remarks>
    /// Returns a paginated list of employees working in the current hospital.
    /// Supports search by name or email. Only accessible to hospital administrators.
    /// </remarks>
    /// <param name="query">Pagination and search parameters.</param>
    /// <returns>Paged list of hospital employees.</returns>
    [HttpGet("employees", Name = nameof(GetHospitalEmployees))]
    [Authorize(Policy = "HospitalAdminOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<HospitalEmployeeDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalEmployees([FromQuery] GetHospitalEmployeesQuery query)
    {
        if (_currentUserService.HospitalId is not { } hospitalId) return Unauthorized();
        query.HospitalId = hospitalId;
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get hospital employee details.
    /// </summary>
    /// <remarks>
    /// Returns detailed information about a specific employee in the current hospital.
    /// Only accessible to hospital administrators.
    /// </remarks>
    /// <param name="employeeProfileId">The employee profile ID.</param>
    /// <returns>Employee details.</returns>
    [HttpGet("employees/{employeeProfileId:guid}", Name = nameof(GetHospitalEmployeeDetails))]
    [Authorize(Policy = "HospitalAdminOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<HospitalEmployeeDetailsDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalEmployeeDetails(Guid employeeProfileId)
    {
        if (_currentUserService.HospitalId is not { } hospitalId) return Unauthorized();
        var result = await _mediator.Send(new GetHospitalEmployeeDetailsQuery(hospitalId, employeeProfileId));
        return HandleResult(result);
    }
}