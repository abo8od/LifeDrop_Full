using Api.Common;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.EntityFrameworkCore;
using Npgsql;

namespace Api.Middleware;

public class GlobalExceptionHandler : IExceptionHandler
{
    private readonly ILogger<GlobalExceptionHandler> _logger;

    public GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger)
    {
        _logger = logger;
    }

    public async ValueTask<bool> TryHandleAsync(HttpContext context, Exception exception, CancellationToken cancellationToken)
    {
        _logger.LogError(exception, "Unhandled exception");

        string message;
        string errorCode;

        if (exception is DbUpdateException dbEx &&
            dbEx.InnerException is PostgresException pgEx)
        {
            // Foreign key violation
            if (pgEx.SqlState == "23503")
            {
                message = "Invalid reference data provided.";
                errorCode = "db.invalid_reference";
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
            }
            else
            {
                message = "Database error occurred.";
                errorCode = "db.error";
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
            }
        }
        else
        {
            message = "An unexpected error occurred. Please try again later.";
            errorCode = "common.server_error";
            context.Response.StatusCode = StatusCodes.Status500InternalServerError;
        }

        var response = new ApiResponse<object>
        {
            Code = context.Response.StatusCode,
            Message = message,
            Data = new { errors = new[] { errorCode } }
        };

        context.Response.ContentType = "application/json";

        await context.Response.WriteAsJsonAsync(response, cancellationToken);

        return true;
    }
}
