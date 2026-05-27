using FirebaseAdmin.Messaging;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Interfaces;
using Infrastructure.Data;

namespace Infrastructure.Services;

public class FirebasePushNotificationService : IPushNotificationService
{
    private const int BatchSize = 500;
    private const int MaxRetries = 3;

    private readonly AppDbContext _context;
    private readonly ILogger<FirebasePushNotificationService> _logger;

    public FirebasePushNotificationService(AppDbContext context, ILogger<FirebasePushNotificationService> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task SendToUserAsync(
        Guid userId,
        string title,
        string body,
        Dictionary<string, string>? data = null,
        CancellationToken cancellationToken = default)
    {
        var tokens = await _context.DeviceTokens
            .Where(t => t.UserId == userId)
            .Select(t => t.Token)
            .ToListAsync(cancellationToken);

        if (tokens.Count == 0) return;

        await SendMulticastAsync(tokens, title, body, data, cancellationToken);
    }

    public async Task SendToUsersAsync(
        IEnumerable<Guid> userIds,
        string title,
        string body,
        Dictionary<string, string>? data = null,
        CancellationToken cancellationToken = default)
    {
        var userIdList = userIds.ToList();
        if (userIdList.Count == 0) return;

        var tokens = await _context.DeviceTokens
            .Where(t => userIdList.Contains(t.UserId))
            .Select(t => t.Token)
            .ToListAsync(cancellationToken);

        if (tokens.Count == 0) return;

        await SendMulticastAsync(tokens, title, body, data, cancellationToken);
    }

    private async Task SendMulticastAsync(
        List<string> tokens,
        string title,
        string body,
        Dictionary<string, string>? data,
        CancellationToken cancellationToken)
    {
        for (int i = 0; i < tokens.Count; i += BatchSize)
        {
            var batch = tokens.Skip(i).Take(BatchSize).ToList();

            var message = new MulticastMessage
            {
                Tokens = batch,
                Notification = new Notification { Title = title, Body = body },
                Data = data,
                Android = new AndroidConfig
                {
                    Priority = Priority.High,
                    Notification = new AndroidNotification
                    {
                        Title = title,
                        Body = body,
                        ChannelId = "lifedrop_critical"
                    }
                },
                Apns = new ApnsConfig
                {
                    Headers = new Dictionary<string, string>
                    {
                        { "apns-priority", "10" }
                    },
                    Aps = new Aps
                    {
                        Sound = "default",
                        Badge = 1,
                        MutableContent = true
                    }
                }
            };

            BatchResponse? result = null;

            for (int attempt = 1; attempt <= MaxRetries; attempt++)
            {
                try
                {
                    result = await FirebaseMessaging.DefaultInstance
                        .SendEachForMulticastAsync(message, cancellationToken);
                    break;
                }
                catch (FirebaseMessagingException ex) when (
                    attempt < MaxRetries && IsTransient(ex.MessagingErrorCode))
                {
                    var delay = TimeSpan.FromSeconds(Math.Pow(2, attempt));
                    _logger.LogWarning(
                        "FCM transient error ({ErrorCode}), retrying in {Delay}s (attempt {Attempt}/{Max}).",
                        ex.MessagingErrorCode, delay.TotalSeconds, attempt, MaxRetries);
                    await Task.Delay(delay, cancellationToken);
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "FCM multicast failed for batch of {Count} tokens.", batch.Count);
                    return;
                }
            }

            if (result == null) return;

            _logger.LogInformation(
                "FCM multicast: {SuccessCount} sent, {FailureCount} failed out of {Total} tokens.",
                result.SuccessCount, result.FailureCount, batch.Count);

            // Log each failure with its error code so we can diagnose the root cause
            for (int j = 0; j < result.Responses.Count; j++)
            {
                var r = result.Responses[j];
                if (!r.IsSuccess)
                {
                    var suffix = batch[j].Length >= 8 ? batch[j][^8..] : batch[j];
                    if (r.Exception is FirebaseMessagingException fme)
                        _logger.LogWarning(
                            "FCM token failure — ErrorCode: {ErrorCode}, Message: {Message}, Token (last 8): ...{TokenSuffix}",
                            fme.MessagingErrorCode, fme.Message, suffix);
                    else
                        _logger.LogWarning(
                            "FCM token failure — Exception: {ExceptionType}: {Message}, Token (last 8): ...{TokenSuffix}",
                            r.Exception?.GetType().Name, r.Exception?.Message, suffix);
                }
            }

            await CleanupInvalidTokensAsync(batch, result, cancellationToken);
        }
    }

    private static bool IsTransient(MessagingErrorCode? errorCode) =>
        errorCode is MessagingErrorCode.Internal
                  or MessagingErrorCode.Unavailable
                  or MessagingErrorCode.QuotaExceeded;

    /// <summary>Remove device tokens that FCM rejected as permanently invalid.</summary>
    private async Task CleanupInvalidTokensAsync(
        List<string> tokens,
        BatchResponse result,
        CancellationToken cancellationToken)
    {
        var invalidTokens = result.Responses
            .Select((r, index) => new { r, index })
            .Where(x => !x.r.IsSuccess &&
                        x.r.Exception is FirebaseMessagingException fme &&
                        fme.MessagingErrorCode is
                            MessagingErrorCode.Unregistered or
                            MessagingErrorCode.InvalidArgument)
            .Select(x => tokens[x.index])
            .ToList();

        if (invalidTokens.Count == 0) return;

        await _context.DeviceTokens
            .Where(t => invalidTokens.Contains(t.Token))
            .ExecuteDeleteAsync(cancellationToken);

        _logger.LogInformation("Removed {Count} invalid/unregistered FCM tokens.", invalidTokens.Count);
    }
}
