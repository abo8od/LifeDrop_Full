using Core.Common;
using Core.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.DonationRequests.AcceptDonationRequest;
using Services.Features.DonationRequests.CancelAcceptance;
using Services.Features.DonationRequests.CancelRequest;
using Services.Features.DonationRequests.CreateDonationRequest;
using Services.Features.DonationRequests.FulfillAcceptance;
using Services.Features.DonationRequests.MarkAcceptanceNoShow;
using Services.Features.DonationRequests.Queries.GetDonorFeed;
using Services.Features.DonationRequests.Queries.GetHospitalRequests;
using Services.Features.DonationRequests.Queries.GetHospitalRequestDetails;
using Services.Features.DonationRequests.Queries.GetDonorDonationRequestDetails;
using Services.Features.DonationRequests.Queries.GetActiveDonationStatus;
using Services.Features.DonationRequests.Queries.GetDonorActiveRequests;
using Shared.Responses;
using Api.Common;
using Services.Interfaces;

namespace Api.Controllers;

/// <summary>
/// API controller for managing blood donation requests.
/// Provides endpoints for creating, accepting, and managing donation requests.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[Microsoft.AspNetCore.Http.Tags("Donation Requests")]
public class DonationRequestsController : BaseController
{
    private readonly IMediator _mediator;
    private readonly ICurrentUserService _currentUserService;

    public DonationRequestsController(IMediator mediator, ICurrentUserService currentUserService)
    {
        _mediator = mediator;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Create donation request.
    /// </summary>
    /// <remarks>
    /// Creates a new blood donation request. Only accessible to hospital employees.
    /// </remarks>
    /// <param name="command">The donation request creation command containing blood type, urgency, target quota, and target districts.</param>
    /// <returns>The created donation request with its ID and status.</returns>
    [HttpPost(Name = nameof(CreateDonationRequest))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CreateDonationRequestResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> CreateDonationRequest([FromBody] CreateDonationRequestCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Accept donation request.
    /// </summary>
    /// <remarks>
    /// Accepts a blood donation request. Only accessible to verified donors. Checks blood type compatibility and location.
    /// </remarks>
    /// <param name="requestId">The unique identifier of the donation request to accept.</param>
    /// <param name="idempotencyKey">Optional idempotency key to prevent duplicate acceptances.</param>
    /// <returns>The acceptance confirmation with acceptance ID and status.</returns>
    [HttpPost("{requestId}/accept", Name = nameof(AcceptDonationRequest))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<AcceptDonationRequestResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> AcceptDonationRequest(Guid requestId, [FromHeader(Name = "X-Idempotency-Key")] Guid? idempotencyKey)
    {
        if (!idempotencyKey.HasValue)
        {
            return BadRequest(new ApiResponse<object>
            {
                Code = 400,
                Message = "X-Idempotency-Key header is required.",
                Data = new { errors = new[] { "validation.idempotency_key_required" } }
            });
        }

        var acceptCommand = new AcceptDonationRequestCommand(requestId, idempotencyKey.Value);
        var result = await _mediator.Send(acceptCommand);
        return HandleResult(result);
    }

    /// <summary>
    /// Get personalized donor feed.
    /// </summary>
    /// <remarks>
    /// Gets personalized donation request feed for donors. Filters by location (governorate/district) and blood type compatibility.
    /// </remarks>
    /// <param name="query">Pagination and filtering parameters.</param>
    /// <returns>Paged list of donation requests compatible with the donor's profile.</returns>
    [HttpGet("feed", Name = nameof(GetDonorFeed))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<DonationRequestFeedDto>>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonorFeed([FromQuery] GetDonorFeedQuery query)
    {
        query.UserId = _currentUserService.UserId;
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get hospital donation requests.
    /// </summary>
    /// <remarks>
    /// Gets all donation requests for the hospital dashboard. Only returns requests created by the authenticated hospital.
    /// </remarks>
    /// <param name="query">Pagination and optional status filter.</param>
    /// <returns>Paged list of the hospital's donation requests with fulfillment statistics.</returns>
    [HttpGet(Name = nameof(GetHospitalRequests))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<HospitalRequestSummaryDto>>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalRequests([FromQuery] GetHospitalRequestsQuery query)
    {
        query.HospitalId = _currentUserService.HospitalId ?? Guid.Empty;
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get hospital request details.
    /// </summary>
    /// <remarks>
    /// Gets detailed information about a specific donation request. Includes accepted donors with contact information for hospital staff.
    /// </remarks>
    /// <param name="requestId">The unique identifier of the donation request.</param>
    /// <returns>Detailed request information including donor list.</returns>
    [HttpGet("{requestId}", Name = nameof(GetHospitalRequestDetails))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<HospitalRequestDetailsDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetHospitalRequestDetails(Guid requestId)
    {
        var query = new GetHospitalRequestDetailsQuery(requestId);
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get donor view request details.
    /// </summary>
    /// <remarks>
    /// Gets detailed information about a specific donation request for donors. Includes hospital location and current donor's acceptance status.
    /// </remarks>
    /// <param name="requestId">The unique identifier of the donation request.</param>
    /// <returns>Detailed request information for donor view.</returns>
    [HttpGet("{requestId}/details", Name = nameof(GetDonorDonationRequestDetails))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<DonorDonationRequestDetailsDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonorDonationRequestDetails(Guid requestId)
    {
        var query = new GetDonorDonationRequestDetailsQuery(requestId, _currentUserService.UserId);
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Browse all active donation requests for the donor.
    /// </summary>
    /// <remarks>
    /// Returns a paginated list of active requests compatible with the donor's blood type and governorate.
    /// Does not enforce cooldown or availability — donors can browse regardless of current eligibility.
    /// Already-accepted requests are excluded.
    /// </remarks>
    /// <param name="query">Pagination and optional filters (urgency, hospital search term).</param>
    /// <returns>Paged list of compatible active donation requests.</returns>
    [HttpGet("browse", Name = nameof(GetDonorActiveRequests))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<DonorActiveRequestDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonorActiveRequests([FromQuery] GetDonorActiveRequestsQuery query)
    {
        query.UserId = _currentUserService.UserId;
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get current active donation status for donor.
    /// </summary>
    /// <remarks>
    /// Gets the status of the donor's current active donation acceptance. 
    /// If no active acceptance exists, returns 200 with null data.
    /// </remarks>
    /// <returns>Active donation status details including hospital info and remaining time.</returns>
    [HttpGet("active", Name = nameof(GetActiveDonationStatus))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<ActiveDonationStatusDto>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetActiveDonationStatus()
    {
        var query = new GetActiveDonationStatusQuery();
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Fulfill donation acceptance.
    /// </summary>
    /// <remarks>
    /// Marks a donor's acceptance as fulfilled (donation completed). Called by hospital employee when donor arrives and completes donation.
    /// </remarks>
    /// <param name="acceptanceId">The unique identifier of the donation acceptance.</param>
    /// <returns>Confirmation of fulfillment with request status.</returns>
    [HttpPost("acceptances/{acceptanceId}/fulfill", Name = nameof(FulfillAcceptance))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<FulfillAcceptanceResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> FulfillAcceptance(Guid acceptanceId)
    {
        var command = new FulfillAcceptanceCommand(acceptanceId);
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Mark acceptance as no-show.
    /// </summary>
    /// <remarks>
    /// Marks a donor's acceptance as no-show (did not arrive). Frees up the slot for other donors.
    /// </remarks>
    /// <param name="acceptanceId">The unique identifier of the donation acceptance.</param>
    /// <returns>Confirmation of no-show status.</returns>
    [HttpPost("acceptances/{acceptanceId}/no-show", Name = nameof(MarkAcceptanceNoShow))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<MarkAcceptanceNoShowResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> MarkAcceptanceNoShow(Guid acceptanceId)
    {
        var command = new MarkAcceptanceNoShowCommand(acceptanceId);
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Cancel donation request.
    /// </summary>
    /// <remarks>
    /// Cancels an active donation request. Removes the request from donor feeds.
    /// </remarks>
    /// <param name="requestId">The unique identifier of the donation request.</param>
    /// <returns>Confirmation of cancellation.</returns>
    [HttpPost("{requestId}/cancel", Name = nameof(CancelRequest))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CancelRequestResult>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> CancelRequest(Guid requestId)
    {
        var command = new CancelRequestCommand(requestId);
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Cancel own acceptance.
    /// </summary>
    /// <remarks>
    /// Cancels own acceptance (donor withdraws their commitment). Frees up the slot for other donors.
    /// </remarks>
    /// <param name="requestId">The unique identifier of the donation request.</param>
    /// <param name="dto">Cancellation reason and optional note.</param>
    /// <returns>Confirmation of acceptance cancellation.</returns>
    [HttpPost("{requestId}/cancel-acceptance", Name = nameof(CancelAcceptance))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CancelAcceptanceResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> CancelAcceptance(Guid requestId, [FromBody] CancelAcceptanceDto dto)
    {
        var command = new CancelAcceptanceCommand(requestId, dto.CancellationReasonId, dto.Note);
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Get donation certificate.
    /// </summary>
    /// <remarks>
    /// Gets a generated PDF certificate for a fulfilled donation acceptance. Only accessible to the donor who made the donation.
    /// </remarks>
    /// <param name="requestId">The unique identifier of the donation request.</param>
    /// <returns>A PDF file representing the certificate.</returns>
    [HttpGet("{requestId}/certificate", Name = "GetDonationCertificate")]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonationCertificate(Guid requestId)
    {
        var query = new global::Services.Features.DonationRequests.Queries.GetDonationCertificate.GetDonationCertificateQuery(requestId);
        var result = await _mediator.Send(query);

        if (result.IsFailure)
        {
            return HandleResult(result);
        }

        return File(result.Value!, "application/pdf", "certificate.pdf");
    }
}