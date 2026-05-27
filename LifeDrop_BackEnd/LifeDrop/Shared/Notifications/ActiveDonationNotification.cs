namespace Shared.Notifications;

/// <summary>
/// Sent to the donor via SignalR when their active acceptance changes status.
/// Event name: "ActiveDonationUpdated"
/// </summary>
public class ActiveDonationNotification
{
    /// <summary>The donation request this acceptance belongs to.</summary>
    public Guid RequestId { get; init; }

    /// <summary>The specific acceptance record that changed.</summary>
    public Guid AcceptanceId { get; init; }

    /// <summary>New status of the acceptance: "Accepted", "Cancelled", "Fulfilled", "NoShow".</summary>
    public string Status { get; init; } = string.Empty;

    /// <summary>Human-readable message the client can display.</summary>
    public string Message { get; init; } = string.Empty;
}
