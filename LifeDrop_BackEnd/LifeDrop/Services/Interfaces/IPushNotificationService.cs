namespace Services.Interfaces;

public interface IPushNotificationService
{
    /// <summary>Send a push notification to all registered devices of a single user.</summary>
    Task SendToUserAsync(Guid userId, string title, string body, Dictionary<string, string>? data = null, CancellationToken cancellationToken = default);

    /// <summary>Send a push notification to all registered devices of multiple users.</summary>
    Task SendToUsersAsync(IEnumerable<Guid> userIds, string title, string body, Dictionary<string, string>? data = null, CancellationToken cancellationToken = default);
}
