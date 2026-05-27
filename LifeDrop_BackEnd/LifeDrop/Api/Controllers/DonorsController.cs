using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.Donors.GetDonorProfile;
using Services.Features.Donors.GetLeaderboard;
using Services.Features.Donors.RegisterDonor;
using Services.Features.Donors.UpdateDonorProfile;
using Services.Features.Donors.VerifyDonorMedicalInfo;
using Services.Features.Donors.GetGamificationHistory;
using Services.Features.Donors.GetDonationHistory;
using Services.Features.Donors.GetCooldownStatus;
using Services.Features.Donors.GetDonorHome;
using Services.Features.Donors.VerifyRegistration;
using Services.Features.Donors.ResendRegistrationOtp;
using Shared.Responses;
using Api.Common;
using Services.Interfaces;

namespace Api.Controllers;

/// <summary>
/// API controller for donor-related operations.
/// Handles donor registration and medical verification by hospital staff.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[Microsoft.AspNetCore.Http.Tags("Donors")]
public class DonorsController : BaseController
{
    private readonly IMediator _mediator;
    private readonly ICurrentUserService _currentUserService;

    public DonorsController(IMediator mediator, ICurrentUserService currentUserService)
    {
        _mediator = mediator;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Register a new donor.
    /// </summary>
    /// <remarks>
    /// Registers a new donor in the system. Public endpoint - no authentication required.
    /// </remarks>
    /// <param name="command">The donor registration command containing personal details and blood type.</param>
    /// <returns>Registration result with user ID and email.</returns>
    [HttpPost("register", Name = nameof(RegisterDonor))]
    [AllowAnonymous]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("OtpRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<RegisterDonorResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status409Conflict, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> RegisterDonor([FromBody] RegisterDonorCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Verify donor registration.
    /// </summary>
    /// <remarks>
    /// Verifies a donor's registration using an OTP code sent to their email.
    /// Activates the account and returns access tokens.
    /// </remarks>
    /// <param name="command">The verification command with email and OTP.</param>
    /// <returns>Access and refresh tokens on success.</returns>
    [HttpPost("verify-registration", Name = nameof(VerifyRegistration))]
    [AllowAnonymous]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<VerifyRegistrationResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> VerifyRegistration([FromBody] VerifyRegistrationCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Resends the registration verification OTP to the donor's email.
    /// </summary>
    [HttpPost("resend-registration-otp", Name = nameof(ResendRegistrationOtp))]
    [AllowAnonymous]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("OtpRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> ResendRegistrationOtp([FromBody] ResendRegistrationOtpCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Verify donor medical info.
    /// </summary>
    /// <remarks>
    /// Verifies a donor's medical information and blood type.
    /// Only accessible to hospital employees. Used after donor's first successful donation.
    /// </remarks>
    /// <param name="command">The verification command containing the donor's user ID.</param>
    /// <returns>Verification result confirming the donor's medical verification status.</returns>
    [HttpPost("verify", Name = nameof(VerifyDonor))]
    [Authorize(Policy = "HospitalEmployeeOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<VerifyDonorMedicalInfoResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> VerifyDonor([FromBody] VerifyDonorMedicalInfoCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Get current donor profile.
    /// </summary>
    /// <remarks>
    /// Gets the current donor's profile including eligibility status and gamification points.
    /// Only accessible to authenticated donors.
    /// </remarks>
    /// <returns>Donor profile with eligibility information.</returns>
    [HttpGet("me", Name = nameof(GetDonorProfile))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<DonorProfileDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonorProfile()
    {
        var result = await _mediator.Send(new GetDonorProfileQuery(_currentUserService.UserId));
        return HandleResult(result);
    }

    /// <summary>
    /// Updates the current donor's profile (availability status and location).
    /// Only accessible to authenticated donors.
    /// </summary>
    /// <param name="command">The update command containing fields to update.</param>
    /// <returns>Updated donor profile.</returns>
    [HttpPut("me", Name = nameof(UpdateDonorProfile))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<UpdateDonorProfileResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> UpdateDonorProfile([FromBody] UpdateDonorProfileCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Get donor leaderboard.
    /// </summary>
    /// <remarks>
    /// Gets the donor leaderboard, optionally filtered by governorate.
    /// Public endpoint - accessible to everyone.
    /// </remarks>
    /// <param name="query">The query containing optional governorate filter and top N count.</param>
    /// <returns>Leaderboard with top donors.</returns>
    [HttpGet("leaderboard", Name = nameof(GetLeaderboard))]
    [AllowAnonymous]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<LeaderboardResponseDto>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetLeaderboard([FromQuery] GetLeaderboardQuery query)
    {
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get gamification points history.
    /// </summary>
    /// <remarks>
    /// Gets the current donor's gamification points history.
    /// Only accessible to authenticated donors.
    /// </remarks>
    /// <param name="query">The paged query.</param>
    /// <returns>Paged list of point transactions.</returns>
    [HttpGet("me/gamification-history", Name = nameof(GetGamificationHistory))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<GamificationHistoryDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetGamificationHistory([FromQuery] GetGamificationHistoryQuery query)
    {
        query.UserId = _currentUserService.UserId;
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get donation history.
    /// </summary>
    /// <remarks>
    /// Gets the current donor's donation history.
    /// Only accessible to authenticated donors.
    /// </remarks>
    /// <param name="query">The paged query.</param>
    /// <returns>Paged list of past donations.</returns>
    [HttpGet("me/history", Name = nameof(GetDonationHistory))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<PagedResponse<DonationHistoryDto>>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonationHistory([FromQuery] GetDonationHistoryQuery query)
    {
        var result = await _mediator.Send(query with { UserId = _currentUserService.UserId });
        return HandleResult(result);
    }

    /// <summary>
    /// Get donor home screen data.
    /// </summary>
    /// <remarks>
    /// Returns personalized home screen data for the donor including username, cooldown status,
    /// last donation hospital, total contributions, and top 5 active compatible requests.
    /// </remarks>
    /// <returns>Donor home data.</returns>
    [HttpGet("me/home", Name = nameof(GetDonorHome))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<DonorHomeDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetDonorHome()
    {
        var query = new GetDonorHomeQuery { UserId = _currentUserService.UserId };
        var result = await _mediator.Send(query);
        return HandleResult(result);
    }

    /// <summary>
    /// Get cooldown status.
    /// </summary>
    /// <remarks>
    /// Gets the current donor's cooldown status (days remaining until next donation).
    /// Only accessible to authenticated donors.
    /// </remarks>
    /// <returns>Cooldown status with next eligibility date and days remaining.</returns>
    [HttpGet("me/cooldown", Name = nameof(GetCooldownStatus))]
    [Authorize(Policy = "DonorOnly")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<CooldownStatusDto>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> GetCooldownStatus()
    {
        var result = await _mediator.Send(new GetCooldownStatusQuery(_currentUserService.UserId));
        return HandleResult(result);
    }
}