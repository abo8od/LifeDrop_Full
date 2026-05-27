using Core.Common;
using MediatR;
using Microsoft.Extensions.Logging;
using Services.Features.DonationRequests.Events;
using Services.Interfaces;

namespace Services.Features.DonationRequests.Events;

/// <summary>
/// Handler for DonationRequestCreatedEvent.
/// Sends real-time SignalR notifications to compatible donors.
/// </summary>
public class DonationRequestCreatedNotificationHandler : INotificationHandler<DonationRequestCreatedEvent>
{
    private readonly INotificationService _notificationService;
    private readonly ILogger<DonationRequestCreatedNotificationHandler> _logger;

    public DonationRequestCreatedNotificationHandler(
        INotificationService notificationService,
        ILogger<DonationRequestCreatedNotificationHandler> logger)
    {
        _notificationService = notificationService;
        _logger = logger;
    }

    public async Task Handle(
        DonationRequestCreatedEvent notification,
        CancellationToken cancellationToken)
    {
        _logger.LogInformation(
            "Processing donation request created event for request {RequestId}",
            notification.RequestId);

        try
        {
            await _notificationService.NotifyCompatibleDonorsAsync(notification, cancellationToken);
            
            _logger.LogInformation(
                "Successfully sent notifications for request {RequestId}",
                notification.RequestId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex,
                "Error sending notifications for request {RequestId}",
                notification.RequestId);
            
            // Don't throw - notification failure shouldn't break the main flow
        }
    }
}