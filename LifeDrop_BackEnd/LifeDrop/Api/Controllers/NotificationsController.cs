using Api.Common;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;
using Services.Features.Notifications.RegisterDeviceToken;
using Services.Features.Notifications.UnregisterDeviceToken;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
[Produces("application/json")]
[Microsoft.AspNetCore.Http.Tags("Notifications")]
public class NotificationsController : BaseController
{
    private readonly IMediator _mediator;

    public NotificationsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>Register a device token for push notifications.</summary>
    /// <remarks>
    /// Call this after the user logs in and after the app obtains an FCM/APNs token.
    /// Safe to call multiple times — duplicate tokens are upserted, not duplicated.
    /// </remarks>
    [HttpPost("device-token")]
    [EnableRateLimiting("DeviceTokenRateLimiter")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> RegisterDeviceToken([FromBody] RegisterDeviceTokenCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }

    /// <summary>Unregister a device token (e.g. on logout).</summary>
    [HttpDelete("device-token")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse<object>))]
    public async Task<IActionResult> UnregisterDeviceToken([FromBody] UnregisterDeviceTokenCommand command)
    {
        var result = await _mediator.Send(command);
        return HandleResult(result);
    }
}
