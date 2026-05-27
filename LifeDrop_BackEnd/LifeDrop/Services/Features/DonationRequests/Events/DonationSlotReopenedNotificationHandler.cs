using Core.Common;
using Core.Entities;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Features.DonationRequests.Events;
using Services.Interfaces;

namespace Services.Features.DonationRequests.Events;

/// <summary>
/// Handler for DonationSlotReopenedEvent.
/// Fetches request details and notifies compatible donors via SignalR.
/// </summary>
public class DonationSlotReopenedNotificationHandler : INotificationHandler<DonationSlotReopenedEvent>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly INotificationService _notificationService;
    private readonly ILogger<DonationSlotReopenedNotificationHandler> _logger;

    public DonationSlotReopenedNotificationHandler(
        IUnitOfWork unitOfWork,
        INotificationService notificationService,
        ILogger<DonationSlotReopenedNotificationHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _notificationService = notificationService;
        _logger = logger;
    }

    public async Task Handle(
        DonationSlotReopenedEvent notification,
        CancellationToken cancellationToken)
    {
        _logger.LogInformation(
            "Processing slot reopened event for request {RequestId}",
            notification.RequestId);

        try
        {
            await _notificationService.NotifySlotReopenedAsync(notification, cancellationToken);

            _logger.LogInformation(
                "Successfully notified donors for reopened slot request {RequestId}",
                notification.RequestId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex,
                "Error notifying donors for reopened slot request {RequestId}",
                notification.RequestId);
        }
    }
}