using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.Locations.Dtos;
using Services.Features.Locations.GetDistrictsByGovernorate;
using Services.Features.Locations.GetGovernorates;
using Api.Common;

namespace Api.Controllers;

/// <summary>
/// API controller for geographic location data.
/// Provides public endpoints for governorates and districts - no authentication required.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[AllowAnonymous]
[Microsoft.AspNetCore.Http.Tags("Locations")]
public class LocationsController : BaseController
{
    private readonly IMediator _mediator;

    public LocationsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Get all governorates.
    /// </summary>
    /// <remarks>
    /// Gets all governorates in Jordan. Public endpoint - no authentication required.
    /// </remarks>
    /// <returns>List of governorates with their IDs and names.</returns>
    [HttpGet("governorates", Name = nameof(GetGovernorates))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<List<LocationDto>>))]
    public async Task<IActionResult> GetGovernorates()
    {
        var result = await _mediator.Send(new GetGovernoratesQuery());
        return HandleResult(result);
    }

    /// <summary>
    /// Get districts by governorate.
    /// </summary>
    /// <remarks>
    /// Gets all districts within a specific governorate. Public endpoint - no authentication required.
    /// </remarks>
    /// <param name="governorateId">The unique identifier of the governorate.</param>
    /// <returns>List of districts within the specified governorate.</returns>
    [HttpGet("governorates/{governorateId}/districts", Name = nameof(GetDistricts))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<List<LocationDto>>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDistricts(Guid governorateId)
    {
        var result = await _mediator.Send(new GetDistrictsByGovernorateQuery(governorateId));
        return HandleResult(result);
    }
}