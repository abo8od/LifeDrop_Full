using Api.Common;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;

namespace Api.Extensions;

public static class StatusCodePagesExtensions
{
    /// <summary>
    /// Configures custom status code pages to return unified ApiResponse format
    /// instead of the default RFC 9110 ProblemDetails format.
    /// </summary>
    public static IApplicationBuilder UseCustomStatusCodePages(this IApplicationBuilder app)
    {
        app.UseStatusCodePages(async statusCodeContext =>
        {
            var context = statusCodeContext.HttpContext;
            var statusCode = context.Response.StatusCode;

            // Prevent overwriting if response has already started
            if (!context.Response.HasStarted)
            {
                var (message, code) = statusCode switch
                {
                    401 => ("Unauthorized. Please authenticate.", "auth.unauthorized"),
                    403 => ("Forbidden. You do not have permission to access this resource.", "auth.forbidden"),
                    404 => ("The requested endpoint was not found.", "route.not_found"),
                    405 => ("Method not allowed.", "route.method_not_allowed"),
                    408 => ("Request timeout.", "request.timeout"),
                    429 => ("Too many requests. Please slow down and try again later.", "rate_limit.exceeded"),
                    500 => ("An internal server error occurred.", "common.server_error"),
                    502 => ("Bad gateway.", "gateway.error"),
                    503 => ("Service unavailable.", "service.unavailable"),
                    _ => ("An error occurred processing the request.", "common.error")
                };

                var response = new ApiResponse<object>
                {
                    Code = statusCode,
                    Message = message,
                    Data = new { errors = new[] { code } }
                };

                context.Response.ContentType = "application/json";
                await context.Response.WriteAsJsonAsync(response);
            }
        });

        return app;
    }
}