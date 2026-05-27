using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace Api.Extensions;

public static class ApiBehaviorOptionsExtensions
{
    /// <summary>
    /// Configures custom validation error response to prevent leaking internal details.
    /// Returns user-friendly messages without exposing class names, JSON paths, or technical exceptions.
    /// </summary>
    public static IMvcBuilder AddCustomApiBehaviorOptions(this IMvcBuilder builder)
    {
        builder.ConfigureApiBehaviorOptions(options =>
        {
            options.InvalidModelStateResponseFactory = context =>
            {
                var cleanErrors = new List<string>();

                foreach (var (key, modelStateEntry) in context.ModelState)
                {
                    var cleanFieldName = CleanFieldName(key);

                    foreach (var error in modelStateEntry.Errors)
                    {
                        var cleanMessage = GetCleanErrorMessage(error, cleanFieldName);
                        if (!string.IsNullOrWhiteSpace(cleanMessage) && !cleanErrors.Contains(cleanMessage))
                        {
                            cleanErrors.Add(cleanMessage);
                        }
                    }
                }

                if (cleanErrors.Count == 0)
                {
                    cleanErrors.Add("Invalid request data. Please check your input.");
                }

                var response = new Api.Common.ApiResponse<object>
                {
                    Code = StatusCodes.Status400BadRequest,
                    Message = "Validation Error",
                    Data = new { errors = cleanErrors }
                };

                return new BadRequestObjectResult(response);
            };
        });

        return builder;
    }

    private static string CleanFieldName(string fieldName)
    {
        if (string.IsNullOrEmpty(fieldName))
            return string.Empty;

        var clean = fieldName
            .TrimStart('$', '.')
            .Replace(".", " ")
            .Replace("[", " ")
            .Replace("]", " ")
            .Replace("_", " ");

        var words = clean.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        var result = string.Join(" ", words.Select(w => 
            string.IsNullOrEmpty(w) ? w : char.ToUpper(w[0]) + w.Substring(1).ToLower()));

        return result.Trim();
    }

    private static string GetCleanErrorMessage(ModelError error, string fieldName)
    {
        if (error.Exception != null)
        {
            return string.IsNullOrEmpty(fieldName) 
                ? "Invalid data format provided." 
                : $"Invalid value for '{fieldName}'.";
        }

        var rawMessage = error.ErrorMessage;
        
        if (string.IsNullOrWhiteSpace(rawMessage))
        {
            return string.IsNullOrEmpty(fieldName)
                ? "This field is required."
                : $"'{fieldName}' is required.";
        }

        var technicalKeywords = new[] 
        { 
            "could not be converted", 
            "JSON value", 
            "System.", 
            "Guid", 
            "Int32", 
            "DateTime",
            "not be null",
            "invalid"
        };

        var isTechnical = technicalKeywords.Any(k => 
            rawMessage.Contains(k, StringComparison.OrdinalIgnoreCase));

        if (isTechnical)
        {
            return string.IsNullOrEmpty(fieldName)
                ? "Invalid data format provided."
                : $"Invalid format for '{fieldName}'.";
        }

        return rawMessage
            .Replace("$.", "")
            .Trim();
    }
}