using System.Text;
using Api.BackgroundWorkers;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.ResponseCompression;
using Api.Common;
using Api.Extensions;
using Api.Hubs;
using Api.Middleware;
using Api.Services;
using Infrastructure;
using Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Serilog;
using Services;
using Services.Interfaces;

namespace Api;

public class Program
{
    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Structured logging via Serilog — reads configuration from appsettings.json "Serilog" section.
        // In Development: human-readable console output.
        // In Production: JSON console (queryable by log aggregators) + optional Seq sink.
        builder.Host.UseSerilog((ctx, cfg) =>
            cfg.ReadFrom.Configuration(ctx.Configuration));


        // Add controllers with custom validation error handling
        builder.Services.AddControllers()
            .AddJsonOptions(options => 
            {
                // Optimization: Skip null values to reduce JSON payload size
                options.JsonSerializerOptions.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
            })
            .AddCustomApiBehaviorOptions();

        // Response Compression (Gzip/Brotli)
        builder.Services.AddResponseCompression(options => 
        {
            options.EnableForHttps = true;
            options.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(["application/json"]);
        });

        builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
        builder.Services.AddProblemDetails();
        builder.Services.AddEndpointsApiExplorer();

        // Add Swagger documentation with JWT support
        builder.Services.AddSwaggerDocumentation();

        var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
        builder.Services.AddAppDbContext(connectionString!);
        builder.Services.AddRepositories();
        builder.Services.AddSecurityServices(builder.Configuration);
        builder.Services.AddApplicationServices(builder.Configuration);
        builder.Services.AddPdfGenerator();
        builder.Services.AddFirebasePushNotifications(builder.Configuration);
        
        // Authentication & Authorization (JWT)
        builder.Services.AddAuthenticationServices(builder.Configuration);

        // Rate Limiting
        builder.Services.AddCustomRateLimiting();

        // Health checks
        builder.Services.AddHealthChecks();

        // SignalR real-time notifications
        builder.Services.AddSignalR();
        builder.Services.AddScoped<INotificationService, SignalRNotificationService>();
        

        // Background workers for processing expired acceptances and outbox messages
        builder.Services.AddHostedService<DonationTimeoutWorker>();
        builder.Services.AddHostedService<ProcessOutboxMessagesWorker>();

        var app = builder.Build();
        app.UseExceptionHandler();
        app.UseCustomStatusCodePages();
        if (app.Environment.IsDevelopment())
        {
            app.UseSwaggerDocumentation();
        }

        app.UseResponseCompression();

        app.UseSerilogRequestLogging();

        app.UseRateLimiter();

        app.UseAuthentication();
        app.UseAuthorization();

        app.MapControllers();
        app.MapHub<DonationHub>("/hubs/donations");
        app.MapHealthChecks("/health");
        
        app.Run();
    }
}