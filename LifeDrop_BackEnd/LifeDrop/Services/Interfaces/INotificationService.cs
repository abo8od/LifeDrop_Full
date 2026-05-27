using Core.Enums;
using Services.Features.DonationRequests.Events;
using Shared.Notifications;

namespace Services.Interfaces;

/// <summary>
/// Interface for notification services.
/// Implementation is in the Api layer (SignalR).
/// </summary>
public interface INotificationService
{
    /// <summary>
    /// Sends notification to compatible donors when a new donation request is created.
    /// Uses SignalR groups based on governorate and blood type compatibility.
    /// </summary>
    Task NotifyCompatibleDonorsAsync(
        DonationRequestCreatedEvent donationEvent,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Sends notification to a specific user.
    /// </summary>
    Task NotifyUserAsync(
        Guid userId,
        NotificationMessage message,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Sends notification to compatible donors when a donation slot is reopened.
    /// Used when a donor cancels or is marked as no-show.
    /// </summary>
    Task NotifySlotReopenedAsync(
        DonationSlotReopenedEvent slotEvent,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Notifies the user's client that their profile has been updated.
    /// This triggers a SignalR group refresh.
    /// </summary>
    Task NotifyProfileUpdatedAsync(
        Guid userId,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Fires "RequestAccepted" — a donor just accepted the request.
    /// </summary>
    Task NotifyHospitalRequestAcceptedAsync(
        Guid hospitalId,
        Shared.Notifications.RequestAcceptedNotification notification,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Fires "RequestUpdated" — the request's accepted-count or status changed.
    /// </summary>
    Task NotifyHospitalRequestUpdatedAsync(
        Guid hospitalId,
        Shared.Notifications.RequestUpdatedNotification notification,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Fires "DashboardUpdated" — hospital-level aggregate stats changed.
    /// </summary>
    Task NotifyHospitalDashboardUpdatedAsync(
        Guid hospitalId,
        Shared.Notifications.DashboardUpdatedNotification notification,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Fires "AcceptanceUpdated" — an acceptance record changed status.
    /// </summary>
    Task NotifyHospitalAcceptanceUpdatedAsync(
        Guid hospitalId,
        Shared.Notifications.AcceptanceUpdatedNotification notification,
        CancellationToken cancellationToken = default);

    /// <summary>
    /// Fires "ActiveDonationUpdated" directly to the donor whose acceptance changed.
    /// </summary>
    Task NotifyDonorActiveDonationAsync(
        Guid donorUserId,
        Shared.Notifications.ActiveDonationNotification notification,
        CancellationToken cancellationToken = default);
}