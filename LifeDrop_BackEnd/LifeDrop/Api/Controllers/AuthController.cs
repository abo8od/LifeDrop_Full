using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Features.Auth.Bootstrap;
using Services.Features.Auth.Login;
using Services.Features.Auth.Refresh;
using Services.Features.Auth.ForgotPassword;
using Services.Features.Auth.VerifyOtp;
using Services.Features.Auth.ResetPassword;
using Services.Features.Auth.ResendResetPasswordOtp;
using Services.Interfaces;
using Api.Common;

namespace Api.Controllers;

/// <summary>
/// API controller for authentication operations.
/// Handles login, token refresh, and initial user bootstrapping.
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
[Microsoft.AspNetCore.Http.Tags("Authentication")]
public class AuthController : BaseController
{
    private readonly IMediator _mediator;

    public AuthController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Bootstrap initial admin.
    /// </summary>
    /// <remarks>
    /// Bootstraps a new user with role-based data. Used for first-time user setup after registration.
    /// </remarks>
    /// <param name="command">The bootstrap command containing user role details.</param>
    /// <returns>Bootstrapping result with user profile data.</returns>
    [HttpPost("bootstrap", Name = nameof(Bootstrap))]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("LoginRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<BootstrapResult>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> Bootstrap([FromBody] BootstrapCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// User login.
    /// </summary>
    /// <remarks>
    /// Authenticates a user and returns JWT access and refresh tokens.
    /// </remarks>
    /// <param name="command">The login credentials (email and password).</param>
    /// <returns>Authentication tokens (access token and refresh token).</returns>
    [HttpPost("login", Name = nameof(Login))]
    [AllowAnonymous]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("LoginRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<TokenResponse>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> Login([FromBody] LoginCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Refresh access token.
    /// </summary>
    /// <remarks>
    /// Refreshes an expired JWT access token using a valid refresh token.
    /// </remarks>
    /// <param name="command">The refresh token command containing the refresh token.</param>
    /// <returns>New authentication tokens.</returns>
    [HttpPost("refresh", Name = nameof(Refresh))]
    [AllowAnonymous]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("LoginRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<TokenResponse>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> Refresh([FromBody] RefreshTokenCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Forgot password request.
    /// </summary>
    /// <remarks>
    /// Requests a password reset OTP to be sent to the user's email.
    /// </remarks>
    [HttpPost("forgot-password", Name = nameof(ForgotPassword))]
    [AllowAnonymous]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("OtpRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Verify reset OTP.
    /// </summary>
    /// <remarks>
    /// Verifies the OTP sent to the user's email for password reset.
    /// </remarks>
    [HttpPost("verify-otp", Name = nameof(VerifyOtp))]
    [AllowAnonymous]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Reset password.
    /// </summary>
    /// <remarks>
    /// Resets the user's password using a valid OTP.
    /// </remarks>
    [HttpPost("reset-password", Name = nameof(ResetPassword))]
    [AllowAnonymous]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>
    /// Resend reset OTP.
    /// </summary>
    /// <remarks>
    /// Resends the password reset OTP to the user's email.
    /// </remarks>
    [HttpPost("resend-otp", Name = nameof(ResendResetPasswordOtp))]
    [AllowAnonymous]
    [Microsoft.AspNetCore.RateLimiting.EnableRateLimiting("OtpRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> ResendResetPasswordOtp([FromBody] ResendResetPasswordOtpCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }
}