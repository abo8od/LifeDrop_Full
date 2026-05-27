using System.Text;
using Api.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Services.Interfaces;

namespace Api.Extensions;

public static class AuthenticationServiceCollectionExtensions
{
    public static IServiceCollection AddAuthenticationServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = configuration["Jwt:Issuer"],
                    ValidAudience = configuration["Jwt:Audience"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:SecretKey"]!))
                };

                options.Events = new JwtBearerEvents
                {
                    OnMessageReceived = context =>
                    {
                        var accessToken = context.Request.Query["access_token"];
                        var path = context.HttpContext.Request.Path;

                        if (!string.IsNullOrEmpty(accessToken) && path.StartsWithSegments("/hubs"))
                        {
                            context.Token = accessToken;
                        }

                        return Task.CompletedTask;
                    },

                    OnChallenge = context =>
                    {
                        context.HandleResponse();

                        context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                        context.Response.ContentType = "application/json";

                        return context.Response.WriteAsJsonAsync(new Api.Common.ApiResponse<object>
                        {
                            Code = 401,
                            Message = "Unauthorized. Token is missing or invalid.",
                            Data = new { errors = new[] { "auth.unauthorized" } }
                        });
                    },

                    OnForbidden = context =>
                    {
                        context.Response.StatusCode = StatusCodes.Status403Forbidden;
                        context.Response.ContentType = "application/json";

                        return context.Response.WriteAsJsonAsync(new Api.Common.ApiResponse<object>
                        {
                            Code = 403,
                            Message = "Forbidden. You do not have permission to access this resource.",
                            Data = new { errors = new[] { "auth.forbidden" } }
                        });
                    }
                };
            });

        services.AddAuthorization(options =>
        {
            options.AddPolicy("SystemAdminOnly", policy => policy.RequireRole("SystemAdmin"));
            options.AddPolicy("HospitalAdminOnly", policy => policy.RequireRole("HospitalAdmin"));
            options.AddPolicy("HospitalEmployeeOnly", policy => policy.RequireRole("HospitalEmployee", "HospitalAdmin"));
            options.AddPolicy("DonorOnly", policy => policy.RequireRole("Donor"));
        });
        
        services.AddHttpContextAccessor();
        services.AddScoped<ICurrentUserService, CurrentUserService>();

        return services;
    }
}