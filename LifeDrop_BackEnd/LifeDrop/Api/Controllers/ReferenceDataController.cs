using Api.Common;
using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.ReferenceData.Dtos;
using Services.Features.ReferenceData.GetBloodTypes;
using Services.Features.ReferenceData.GetCancellationReasons;

namespace Api.Controllers;

/// <summary>
/// API controller for reference data endpoints.
/// Provides public reference data like blood types that don't require authentication.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[AllowAnonymous]
[Microsoft.AspNetCore.Http.Tags("Reference Data")]
public class ReferenceDataController : BaseController
{
    private readonly IMediator _mediator;

    public ReferenceDataController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Get all blood types.
    /// </summary>
    /// <remarks>
    /// Gets all available blood types in the system. Public endpoint - no authentication required.
    /// </remarks>
    /// <returns>List of blood types with their display names and values.</returns>
    [HttpGet("blood-types", Name = nameof(GetBloodTypes))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<List<BloodTypeDto>>))]
    public async Task<IActionResult> GetBloodTypes()
    {
        var result = await _mediator.Send(new GetBloodTypesQuery());
        return HandleResult(result);
    }

    /// <summary>
    /// Get cancellation reasons.
    /// </summary>
    /// <remarks>
    /// Gets all active cancellation reasons. Public endpoint - no authentication required.
    /// </remarks>
    /// <returns>List of cancellation reasons for dropdown selection.</returns>
    [HttpGet("cancellation-reasons", Name = nameof(GetCancellationReasons))]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<List<CancellationReasonDto>>))]
    public async Task<IActionResult> GetCancellationReasons()
    {
        var result = await _mediator.Send(new GetCancellationReasonsQuery());
        return HandleResult(result);
    }
}