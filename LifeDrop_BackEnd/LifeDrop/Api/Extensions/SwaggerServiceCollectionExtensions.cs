using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using System.IO;
using Microsoft.OpenApi;

namespace Api.Extensions;

/// <summary>
/// Extension methods for configuring Swagger (OpenAPI) documentation.
/// </summary>
public static class SwaggerServiceCollectionExtensions
{
    /// <summary>
    /// Adds Swagger (OpenAPI) documentation services with JWT Bearer authentication support.
    /// </summary>
    /// <param name="services">The service collection.</param>
    /// <returns>The service collection for chaining.</returns>
    public static IServiceCollection AddSwaggerDocumentation(this IServiceCollection services)
    {
        services.AddSwaggerGen(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo
            {
                Title = "LifeDrop API",
                Version = "v1",
                Description = "Blood Donation Application - REST API for connecting donors with hospitals.",
                Contact = new OpenApiContact { Name = "LifeDrop Team" }
            });

            options.CustomSchemaIds(type => type.ToString().Replace("+", "."));
            
            // Add Filters for clean documentation
            options.SchemaFilter<SwaggerSchemaFilter>();
            options.OperationFilter<SwaggerOperationFilter>();
            
            // Add JWT Security Definition
            options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
            {
                Name = "Authorization",
                Type = SecuritySchemeType.Http,
                Scheme = "Bearer",
                BearerFormat = "JWT",
                In = ParameterLocation.Header,
                Description = "Enter your valid token in the text input below.\r\n\r\nExample: \"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\""
            });

            options.AddSecurityRequirement(document => new OpenApiSecurityRequirement
            {
                {
                    new OpenApiSecuritySchemeReference("Bearer"),
                    new System.Collections.Generic.List<string>()
                }
            });

            // Add XML comments for better documentation
            var xmlFiles = Directory.GetFiles(AppContext.BaseDirectory, "*.xml", SearchOption.TopDirectoryOnly);
            foreach (var xmlFile in xmlFiles)
            {
                options.IncludeXmlComments(xmlFile);
            }
        });
        
        return services;
    }
    
    /// <summary>
    /// Configures Swagger UI middleware.
    /// </summary>
    /// <param name="app">The application builder.</param>
    public static void UseSwaggerDocumentation(this IApplicationBuilder app)
    {
        app.UseSwagger();
        app.UseSwaggerUI(options =>
        {
            options.SwaggerEndpoint("/swagger/v1/swagger.json", "LifeDrop API v1");
            options.RoutePrefix = "swagger";
            options.DisplayRequestDuration();
            options.EnableDeepLinking();
            options.EnableFilter();
            options.ShowExtensions();
            options.DisplayOperationId();
        });
    }
}