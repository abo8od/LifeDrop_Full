using Core.Common;
using MediatR;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Features.DonationRequests.ProcessExpiredAcceptances;
using Services.Features.Donors.NotifyEligibleDonors;
using Shared.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Infrastructure.Data;
using System.Linq;

namespace Api.BackgroundWorkers;

/// <summary>
/// Background worker that periodically processes expired donation acceptances.
/// Runs every 15 minutes to check for acceptances that have passed the timeout threshold.
/// </summary>
public class DonationTimeoutWorker : BackgroundService
{
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly ILogger<DonationTimeoutWorker> _logger;
    private readonly DonationSettings _settings;
    private readonly TimeSpan _interval = TimeSpan.FromMinutes(15);
    private DateTime _lastCleanupDate = DateTime.MinValue;

    public DonationTimeoutWorker(
        IServiceScopeFactory scopeFactory,
        ILogger<DonationTimeoutWorker> logger,
        IOptions<DonationSettings> settings)
    {
        _scopeFactory = scopeFactory;
        _logger = logger;
        _settings = settings.Value;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation(
            "DonationTimeoutWorker started. Checking every {Interval} minutes for expired acceptances.",
            _interval.TotalMinutes);

        // Run immediately on startup to handle any backlog
        await ProcessExpiredAcceptancesAsync(stoppingToken);
        await NotifyEligibleDonorsAsync(stoppingToken);

        // Then run periodically
        using var timer = new PeriodicTimer(_interval);

        while (await timer.WaitForNextTickAsync(stoppingToken))
        {
            await ProcessExpiredAcceptancesAsync(stoppingToken);
            await NotifyEligibleDonorsAsync(stoppingToken);

            // Run cleanup once a day
            if (DateTime.UtcNow.Date > _lastCleanupDate)
            {
                await CleanupBloatedTablesAsync(stoppingToken);
                _lastCleanupDate = DateTime.UtcNow.Date;
            }
        }
    }

    private async Task ProcessExpiredAcceptancesAsync(CancellationToken cancellationToken)
    {
        try
        {
            _logger.LogDebug("Checking for expired donation acceptances...");

            using var scope = _scopeFactory.CreateScope();
            var mediator = scope.ServiceProvider.GetRequiredService<IMediator>();

            var result = await mediator.Send(
                new ProcessExpiredAcceptancesCommand(),
                cancellationToken);

            if (result.IsSuccess && result.Value?.ProcessedCount > 0)
            {
                _logger.LogInformation(
                    "Processed {Count} expired acceptances. Penalized {Penalized} donors. Reactivated {Reactivated} requests.",
                    result.Value!.ProcessedCount,
                    result.Value!.PenalizedDonorCount,
                    result.Value!.ReactivatedRequestCount);
            }
            else
            {
                _logger.LogDebug("No expired acceptances found.");
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while processing expired acceptances.");
        }
    }

    private async Task NotifyEligibleDonorsAsync(CancellationToken cancellationToken)
    {
        try
        {
            using var scope = _scopeFactory.CreateScope();
            var mediator = scope.ServiceProvider.GetRequiredService<IMediator>();

            var result = await mediator.Send(new NotifyEligibleDonorsCommand(), cancellationToken);

            if (result.IsSuccess && result.Value?.NotifiedCount > 0)
                _logger.LogInformation("Eligibility restored: notified {Count} donors.", result.Value.NotifiedCount);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while sending eligibility notifications.");
        }
    }

    private async Task CleanupBloatedTablesAsync(CancellationToken cancellationToken)
    {
        try
        {
            _logger.LogInformation("Starting daily database cleanup of bloated tables...");

            using var scope = _scopeFactory.CreateScope();
            var context = scope.ServiceProvider.GetRequiredService<AppDbContext>();

            // 1. Delete used or expired OTP codes (older than 1 day for safety)
            var deletedOtps = await context.OtpCodes
                .Where(o => o.IsUsed || o.ExpiryDate < DateTime.UtcNow.AddDays(-1))
                .ExecuteDeleteAsync(cancellationToken);

            // 2. Delete revoked or expired refresh tokens (older than 30 days)
            var deletedTokens = await context.RefreshTokens
                .Where(t => t.IsRevoked || t.ExpiryDate < DateTime.UtcNow.AddDays(-30))
                .ExecuteDeleteAsync(cancellationToken);

            // 3. Delete expired pending registrations (older than 2 days)
            var deletedPending = await context.PendingRegistrations
                .Where(p => p.OtpExpiryDate < DateTimeOffset.UtcNow.AddDays(-2))
                .ExecuteDeleteAsync(cancellationToken);

            // 4. Delete processed outbox messages older than 7 days
            var deletedOutbox = await context.OutboxMessages
                .Where(o => o.ProcessedOn != null && o.ProcessedOn < DateTimeOffset.UtcNow.AddDays(-7))
                .ExecuteDeleteAsync(cancellationToken);

            // 5. Delete idempotent request records older than 30 days
            var deletedIdempotent = await context.IdempotentRequests
                .Where(i => i.CreatedOn < DateTimeOffset.UtcNow.AddDays(-30))
                .ExecuteDeleteAsync(cancellationToken);

            // 6. Delete device tokens not updated in 30 days (stale / uninstalled apps)
            var deletedDeviceTokens = await context.DeviceTokens
                .Where(t => t.ModifiedOn < DateTimeOffset.UtcNow.AddDays(-30))
                .ExecuteDeleteAsync(cancellationToken);

            if (deletedOtps > 0 || deletedTokens > 0 || deletedPending > 0 || deletedOutbox > 0 || deletedIdempotent > 0 || deletedDeviceTokens > 0)
            {
                _logger.LogInformation(
                    "Cleanup Job completed: Deleted {Otps} OTPs, {Tokens} RefreshTokens, {Pending} PendingRegs, {Outbox} OutboxMessages, {Idempotent} IdempotentRequests, {DeviceTokens} DeviceTokens.",
                    deletedOtps, deletedTokens, deletedPending, deletedOutbox, deletedIdempotent, deletedDeviceTokens);
            }
            else
            {
                _logger.LogInformation("Cleanup Job completed: No records required deletion.");
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while cleaning up bloated tables.");
        }
    }

    public override async Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("DonationTimeoutWorker is stopping.");
        await base.StopAsync(cancellationToken);
    }
}