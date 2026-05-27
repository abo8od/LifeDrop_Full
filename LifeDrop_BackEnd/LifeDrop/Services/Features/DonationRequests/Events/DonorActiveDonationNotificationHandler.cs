using MediatR;
using Microsoft.Extensions.Logging;
using Services.Interfaces;
using Shared.Notifications;

namespace Services.Features.DonationRequests.Events;

/// <summary>
/// Sends "ActiveDonationUpdated" via SignalR directly to the donor whenever their
/// acceptance changes state (accepted, cancelled, fulfilled, no-show).
/// Runs via the Outbox pattern alongside the hospital notification handler.
/// </summary>
public class DonorActiveDonationNotificationHandler :
    INotificationHandler<DonationAcceptedByDonorEvent>,
    INotificationHandler<AcceptanceCancelledByDonorEvent>,
    INotificationHandler<AcceptanceFulfilledEvent>,
    INotificationHandler<AcceptanceNoShowEvent>
{
    private readonly INotificationService _notificationService;
    private readonly ILogger<DonorActiveDonationNotificationHandler> _logger;

    public DonorActiveDonationNotificationHandler(
        INotificationService notificationService,
        ILogger<DonorActiveDonationNotificationHandler> logger)
    {
        _notificationService = notificationService;
        _logger = logger;
    }

    public Task Handle(DonationAcceptedByDonorEvent notification, CancellationToken cancellationToken)
    {
        if (notification.DonorUserId == Guid.Empty) return Task.CompletedTask;

        return _notificationService.NotifyDonorActiveDonationAsync(
            notification.DonorUserId,
            new ActiveDonationNotification
            {
                RequestId    = notification.RequestId,
                AcceptanceId = notification.AcceptanceId,
                Status       = "Accepted",
                Message      = "Your donation commitment has been confirmed."
            },
            cancellationToken);
    }

    public Task Handle(AcceptanceCancelledByDonorEvent notification, CancellationToken cancellationToken)
    {
        if (notification.DonorUserId == Guid.Empty) return Task.CompletedTask;

        return _notificationService.NotifyDonorActiveDonationAsync(
            notification.DonorUserId,
            new ActiveDonationNotification
            {
                RequestId    = notification.RequestId,
                AcceptanceId = notification.AcceptanceId,
                Status       = "Cancelled",
                Message      = "Your donation commitment has been cancelled."
            },
            cancellationToken);
    }

    public Task Handle(AcceptanceFulfilledEvent notification, CancellationToken cancellationToken)
    {
        if (notification.DonorUserId == Guid.Empty) return Task.CompletedTask;

        return _notificationService.NotifyDonorActiveDonationAsync(
            notification.DonorUserId,
            new ActiveDonationNotification
            {
                RequestId    = notification.RequestId,
                AcceptanceId = notification.AcceptanceId,
                Status       = "Fulfilled",
                Message      = "Thank you! Your donation has been marked as fulfilled."
            },
            cancellationToken);
    }

    public Task Handle(AcceptanceNoShowEvent notification, CancellationToken cancellationToken)
    {
        if (notification.DonorUserId == Guid.Empty) return Task.CompletedTask;

        return _notificationService.NotifyDonorActiveDonationAsync(
            notification.DonorUserId,
            new ActiveDonationNotification
            {
                RequestId    = notification.RequestId,
                AcceptanceId = notification.AcceptanceId,
                Status       = "NoShow",
                Message      = "You were marked as a no-show for this donation request."
            },
            cancellationToken);
    }
}
