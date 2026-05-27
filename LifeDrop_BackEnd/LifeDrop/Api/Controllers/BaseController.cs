using Api.Common;
using Core.Common;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

public class BaseController : ControllerBase
{
    protected IActionResult HandleResult(Result result)
    {
        if (result.IsSuccess)
        {
            return Ok(new ApiResponse<object>
            {
                Code = StatusCodes.Status200OK,
                Message = "Success",
                Data = null
            });
        }
        return CreateErrorResponse(result.Error);
    }

    protected IActionResult HandleResult<T>(Result<T> result)
    {
        if (result.IsSuccess)
        {
            return Ok(new ApiResponse<T>
            {
                Code = StatusCodes.Status200OK,
                Message = "Success",
                Data = result.Value
            });
        }
        return CreateErrorResponse(result.Error);
    }

    private IActionResult CreateErrorResponse(Error error)
    {
        var statusCode = GetStatusCode(error.Type);
        var errors = new List<string>();

        if (!string.IsNullOrEmpty(error.Code))
        {
            errors.Add(error.Code);
        }

        if (error.ValidationErrors != null && error.ValidationErrors.Any())
        {
            foreach (var kvp in error.ValidationErrors)
            {
                errors.AddRange(kvp.Value);
            }
        }

        var response = new ApiResponse<object>
        {
            Code = statusCode,
            Message = error.Description,
            Data = new { errors = errors }
        };

        return StatusCode(statusCode, response);
    }

    private static int GetStatusCode(ErrorType errorType) => errorType switch
    {
        ErrorType.NotFound => StatusCodes.Status404NotFound,
        ErrorType.Validation => StatusCodes.Status400BadRequest,
        ErrorType.Conflict => StatusCodes.Status409Conflict,
        ErrorType.Unauthorized => StatusCodes.Status401Unauthorized,
        ErrorType.Failure => StatusCodes.Status400BadRequest,
        _ => StatusCodes.Status400BadRequest
    };
}
