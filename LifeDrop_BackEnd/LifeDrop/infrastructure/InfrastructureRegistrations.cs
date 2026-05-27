using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using Services.Interfaces;
using Infrastructure.Data;
using Infrastructure.Data.Interceptors;
using Infrastructure.Repositories;
using Infrastructure.Security;
using Infrastructure.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Services.Abstractions;
using Services.Abstractions.Persistence;
using Shared.Configuration;

namespace Infrastructure;

public static class InfrastructureRegistrations
{
    public static void AddAppDbContext(this IServiceCollection services, string connectionString)
    {
        services.AddSingleton<ConvertDomainEventsToOutboxMessagesInterceptor>();

        services.AddDbContext<AppDbContext>((sp, o) => 
        {
            var interceptor = sp.GetRequiredService<ConvertDomainEventsToOutboxMessagesInterceptor>();
            o.UseNpgsql(connectionString)
             .AddInterceptors(interceptor);
        });
        
        services.AddScoped<IUnitOfWork, UnitOfWork>();
    }

    public static void AddRepositories(this IServiceCollection services)
    {
        services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
    }

    public static void AddSecurityServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<JwtSettings>(configuration.GetSection("Jwt"));
        services.Configure<DonationSettings>(configuration.GetSection("DonationSettings"));
        services.Configure<EmailSettings>(configuration.GetSection("EmailSettings"));
        services.AddScoped<IPasswordHasher, PasswordHasher>();
        services.AddScoped<IJwtTokenGenerator, JwtTokenGenerator>();
        services.AddSingleton<IEmailService, SmtpEmailService>();
        services.AddSingleton<IOtpService, OtpService>();
    }

    public static void AddPdfGenerator(this IServiceCollection services)
    {
        services.AddScoped<LifeDrop.Services.Abstractions.IPdfCertificateGenerator, QuestPdfCertificateGenerator>();
    }

    public static void AddFirebasePushNotifications(this IServiceCollection services, IConfiguration configuration)
    {
        var credentialJson = configuration["Firebase:ServiceAccountJson"];

        if (!string.IsNullOrWhiteSpace(credentialJson))
        {
            if (FirebaseApp.DefaultInstance == null)
            {
                try
                {
                    FirebaseApp.Create(new AppOptions
                    {
                        Credential = GoogleCredential.FromJson(credentialJson)
                    });
                }
                catch (Exception ex)
                {
                    throw new InvalidOperationException(
                        "Failed to initialize Firebase. Verify Firebase:ServiceAccountJson is valid.", ex);
                }
            }
        }

        services.AddScoped<IPushNotificationService, FirebasePushNotificationService>();
    }
}
