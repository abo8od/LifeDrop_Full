using Microsoft.OpenApi;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Api.Extensions;

/// <summary>
/// A Swagger operation filter to programmatically add descriptions to API operation parameters.
/// This covers Query Parameters (URL).
/// </summary>
public class SwaggerOperationFilter : IOperationFilter
{
    public void Apply(OpenApiOperation operation, OperationFilterContext context)
    {
        if (operation.Parameters == null) return;

        foreach (var parameter in operation.Parameters)
        {
            if (string.IsNullOrEmpty(parameter.Name)) continue;
            
            var description = SwaggerDocumentationHelper.GetDescription(parameter.Name);
            if (description != null)
            {
                parameter.Description = description;
            }
        }
    }
}
