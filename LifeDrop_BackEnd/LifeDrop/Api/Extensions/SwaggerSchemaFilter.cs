using Microsoft.OpenApi;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Api.Extensions;

/// <summary>
/// A Swagger schema filter to programmatically add descriptions to API models.
/// This covers Request/Response bodies (JSON).
/// </summary>
public class SwaggerSchemaFilter : ISchemaFilter
{
    public void Apply(IOpenApiSchema schema, SchemaFilterContext context)
    {
        if (schema.Properties == null) return;

        foreach (var property in schema.Properties)
        {
            var description = SwaggerDocumentationHelper.GetDescription(property.Key);
            if (description != null)
            {
                property.Value.Description = description;
            }
        }
    }
}
