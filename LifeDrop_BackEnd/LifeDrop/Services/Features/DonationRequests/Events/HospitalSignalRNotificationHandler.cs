using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Notifications;

namespace Services.Features.DonationRequests.Events;

public class HospitalSignalRNotificationHandler :
    INotificationHandler<DonationAcceptedByDonorEvent>,
    INotificationHandler<AcceptanceCancelledByDonorEvent>,
    INotificationHandler<AcceptanceFulfilledEvent>,
    INotificationHandler<AcceptanceNoShowEvent>
{
    private readonly INotificationService _notificationService;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<HospitalSignalRNotificationHandler> _logger;

    public HospitalSignalRNotificationHandler(
        INotificationService notificationService,
        IUnitOfWork unitOfWork,
        ILogger<HospitalSignalRNotificationHandler> logger)
    {
        _notificationService = notificationService;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task Handle(DonationAcceptedByDonorEvent notification, CancellationToken cancellationToken)
    {
        var requestStatus = notification.RequestStatus.ToString();

        var tasks = new List<Task>
        {
            // 1. RequestAccepted — donor detail card
            _notificationService.NotifyHospitalRequestAcceptedAsync(
                notification.HospitalId,
                new RequestAcceptedNotification
                {
                    RequestId    = notification.RequestId,
                    AcceptanceId = notification.AcceptanceId,
                    DonorName    = notification.DonorFullName,
                    BloodType    = notification.BloodType.ToString(),
                    Status       = AcceptanceStatus.Accepted.ToString(),
                    AcceptedAt   = notification.AcceptedAt
                },
                cancellationToken),

            // 2. RequestUpdated — progress bar / quota indicator
            _notificationService.NotifyHospitalRequestUpdatedAsync(
                notification.HospitalId,
                new RequestUpdatedNotification
                {
                    RequestId     = notification.RequestId,
                    Status        = requestStatus,
                    FulfilledCount = notification.CurrentActiveAcceptances,
                    TargetQuota   = notification.TargetQuota,
                    DonorProgress = notification.TargetQuota > 0
                        ? (double)notification.CurrentActiveAcceptances / notification.TargetQuota
                        : 0
                },
                cancellationToken),

            // 3. AcceptanceUpdated — acceptance table row
            _notificationService.NotifyHospitalAcceptanceUpdatedAsync(
                notification.HospitalId,
                new AcceptanceUpdatedNotification
                {
                    RequestId    = notification.RequestId,
                    AcceptanceId = notification.AcceptanceId,
                    Status       = AcceptanceStatus.Accepted.ToString()
                },
                cancellationToken)
        };

        // 4. DashboardUpdated — aggregate stats (requires DB query)
        var dashboard = await BuildDashboardAsync(notification.HospitalId, cancellationToken);
        tasks.Add(_notificationService.NotifyHospitalDashboardUpdatedAsync(
            notification.HospitalId, dashboard, cancellationToken));

        await Task.WhenAll(tasks);

        _logger.LogInformation(
            "Hospital {HospitalId} notified (4 events): donor accepted request {RequestId} ({Count}/{Quota}).",
            notification.HospitalId, notification.RequestId,
            notification.CurrentActiveAcceptances, notification.TargetQuota);
    }

    public async Task Handle(AcceptanceCancelledByDonorEvent notification, CancellationToken cancellationToken)
    {
        var tasks = new List<Task>
        {
            // 1. RequestUpdated — progress changed after cancellation
            _notificationService.NotifyHospitalRequestUpdatedAsync(
                notification.HospitalId,
                new RequestUpdatedNotification
                {
                    RequestId     = notification.RequestId,
                    Status        = "Active",
                    FulfilledCount = notification.CurrentActiveAcceptances,
                    TargetQuota   = notification.TargetQuota,
                    DonorProgress = notification.TargetQuota > 0
                        ? (double)notification.CurrentActiveAcceptances / notification.TargetQuota
                        : 0
                },
                cancellationToken),

            // 2. AcceptanceUpdated — row status changed to CancelledByDonor
            _notificationService.NotifyHospitalAcceptanceUpdatedAsync(
                notification.HospitalId,
                new AcceptanceUpdatedNotification
                {
                    RequestId    = notification.RequestId,
                    AcceptanceId = notification.AcceptanceId,
                    Status       = AcceptanceStatus.CancelledByDonor.ToString()
                },
                cancellationToken)
        };

        // 3. DashboardUpdated — aggregate stats
        var dashboard = await BuildDashboardAsync(notification.HospitalId, cancellationToken);
        tasks.Add(_notificationService.NotifyHospitalDashboardUpdatedAsync(
            notification.HospitalId, dashboard, cancellationToken));

        await Task.WhenAll(tasks);

        _logger.LogInformation(
            "Hospital {HospitalId} notified (3 events): acceptance cancelled on request {RequestId}.",
            notification.HospitalId, notification.RequestId);
    }

    public async Task Handle(AcceptanceNoShowEvent notification, CancellationToken cancellationToken)
    {
        var tasks = new List<Task>
        {
            // 1. AcceptanceUpdated — row status changed to NoShow
            _notificationService.NotifyHospitalAcceptanceUpdatedAsync(
                notification.HospitalId,
                new AcceptanceUpdatedNotification
                {
                    RequestId    = notification.RequestId,
                    AcceptanceId = notification.AcceptanceId,
                    Status       = AcceptanceStatus.NoShow.ToString()
                },
                cancellationToken),

            // 2. RequestUpdated — slot freed, active count decremented
            _notificationService.NotifyHospitalRequestUpdatedAsync(
                notification.HospitalId,
                new RequestUpdatedNotification
                {
                    RequestId      = notification.RequestId,
                    Status         = "Active",
                    FulfilledCount = notification.CurrentActiveAcceptances,
                    TargetQuota    = notification.TargetQuota,
                    DonorProgress  = notification.TargetQuota > 0
                        ? (double)notification.CurrentActiveAcceptances / notification.TargetQuota
                        : 0
                },
                cancellationToken)
        };

        // 3. DashboardUpdated — aggregate stats
        var dashboard = await BuildDashboardAsync(notification.HospitalId, cancellationToken);
        tasks.Add(_notificationService.NotifyHospitalDashboardUpdatedAsync(
            notification.HospitalId, dashboard, cancellationToken));

        await Task.WhenAll(tasks);

        _logger.LogInformation(
            "Hospital {HospitalId} notified (3 events): acceptance {AcceptanceId} marked no-show on request {RequestId}.",
            notification.HospitalId, notification.AcceptanceId, notification.RequestId);
    }

    public async Task Handle(AcceptanceFulfilledEvent notification, CancellationToken cancellationToken)
    {
        var tasks = new List<Task>
        {
            // 1. AcceptanceUpdated — row status changed to Fulfilled
            _notificationService.NotifyHospitalAcceptanceUpdatedAsync(
                notification.HospitalId,
                new AcceptanceUpdatedNotification
                {
                    RequestId    = notification.RequestId,
                    AcceptanceId = notification.AcceptanceId,
                    Status       = AcceptanceStatus.Fulfilled.ToString()
                },
                cancellationToken),

            // 2. RequestUpdated — fulfilled count and status (may now be Fulfilled)
            _notificationService.NotifyHospitalRequestUpdatedAsync(
                notification.HospitalId,
                new RequestUpdatedNotification
                {
                    RequestId      = notification.RequestId,
                    Status         = notification.RequestStatus.ToString(),
                    FulfilledCount = notification.CurrentFulfilledAcceptances,
                    TargetQuota    = notification.TargetQuota,
                    DonorProgress  = notification.TargetQuota > 0
                        ? (double)notification.CurrentFulfilledAcceptances / notification.TargetQuota
                        : 0
                },
                cancellationToken)
        };

        // 3. DashboardUpdated — aggregate stats
        var dashboard = await BuildDashboardAsync(notification.HospitalId, cancellationToken);
        tasks.Add(_notificationService.NotifyHospitalDashboardUpdatedAsync(
            notification.HospitalId, dashboard, cancellationToken));

        await Task.WhenAll(tasks);

        _logger.LogInformation(
            "Hospital {HospitalId} notified (3 events): acceptance {AcceptanceId} fulfilled on request {RequestId}. Request status: {Status}.",
            notification.HospitalId, notification.AcceptanceId, notification.RequestId, notification.RequestStatus);
    }

    private async Task<DashboardUpdatedNotification> BuildDashboardAsync(
        Guid hospitalId,
        CancellationToken cancellationToken)
    {
        var stats = await _unitOfWork.DonationRequests
            .Query()
            .AsNoTracking()
            .Where(r => r.HospitalId == hospitalId)
            .GroupBy(r => r.Status)
            .Select(g => new { Status = g.Key, Count = g.Count() })
            .ToListAsync(cancellationToken);

        var active    = stats.FirstOrDefault(s => s.Status == RequestStatus.Active)?.Count    ?? 0;
        var fulfilled = stats.FirstOrDefault(s => s.Status == RequestStatus.Fulfilled)?.Count ?? 0;
        var canceled  = stats.FirstOrDefault(s => s.Status == RequestStatus.Cancelled)?.Count ?? 0;
        var total     = active + fulfilled + canceled;

        var totalBags = await _unitOfWork.DonationAcceptances
            .Query()
            .AsNoTracking()
            .CountAsync(a => a.DonationRequest!.HospitalId == hospitalId &&
                             a.Status == AcceptanceStatus.Fulfilled,
                        cancellationToken);

        return new DashboardUpdatedNotification
        {
            ActiveRequests    = active,
            FulfilledRequests = fulfilled,
            CanceledRequests  = canceled,
            CompletionRate    = total > 0 ? Math.Round((double)fulfilled / total * 100, 1) : 0,
            TotalBags         = totalBags
        };
    }
}
