using Core.Enums;

namespace Shared.Notifications;

/// <summary>
/// Base notification message for push notifications.
/// </summary>
public class NotificationMessage
{
    public string Title { get; init; } = string.Empty;
    public string Body { get; init; } = string.Empty;
    public NotificationType Type { get; init; }
}

/// <summary>
/// Notification sent when a new donation request matches a donor's profile.
/// </summary>
public class NewDonationRequestNotification : NotificationMessage
{
    public Guid RequestId { get; init; }
    public string HospitalName { get; init; } = string.Empty;
    public string GovernorateName { get; init; } = string.Empty;
    public BloodType RequiredBloodType { get; init; }
    public UrgencyLevel Urgency { get; init; }
    public DateTimeOffset ExpiryDate { get; init; }
}

/// <summary>
/// Types of notifications for the mobile app to handle appropriately.
/// </summary>
public enum NotificationType
{
    NewDonationRequest,
    RequestFulfilled,
    Reminder,
    SlotReopened
}