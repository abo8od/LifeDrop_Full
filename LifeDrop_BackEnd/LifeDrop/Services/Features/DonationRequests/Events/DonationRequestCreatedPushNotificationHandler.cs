using Core.Enums;
using Core.Helpers;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Configuration;

namespace Services.Features.DonationRequests.Events;

/// <summary>
/// Sends FCM/APNs push notifications to compatible donors when a new donation request is created.
/// Runs in parallel with the SignalR handler via the Outbox pattern.
/// </summary>
public class DonationRequestCreatedPushNotificationHandler : INotificationHandler<DonationRequestCreatedEvent>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPushNotificationService _pushNotificationService;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<DonationRequestCreatedPushNotificationHandler> _logger;

    public DonationRequestCreatedPushNotificationHandler(
        IUnitOfWork unitOfWork,
        IPushNotificationService pushNotificationService,
        IOptions<DonationSettings> donationSettings,
        ILogger<DonationRequestCreatedPushNotificationHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _pushNotificationService = pushNotificationService;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task Handle(DonationRequestCreatedEvent notification, CancellationToken cancellationToken)
    {
        try
        {
            var compatibleDonorBloodTypes = notification.BloodType.GetCompatibleDonorBloodTypes().ToList();
            var cooldownCutoff = DateTimeOffset.UtcNow.AddDays(-_donationSettings.CooldownDays);

            var targetUserIds = await _unitOfWork.DonorProfiles
                .Query()
                .AsNoTracking()
                .Where(p =>
                    p.GovernorateId == notification.GovernorateId &&
                    p.IsAvailable &&
                    p.BloodType.HasValue &&
                    compatibleDonorBloodTypes.Contains(p.BloodType.Value) &&
                    (!p.LastDonationDate.HasValue || p.LastDonationDate.Value <= cooldownCutoff) &&
                    (
                        (notification.Urgency == UrgencyLevel.Critical && p.ReceiveCriticalNotifications) ||
                        (notification.Urgency == UrgencyLevel.Urgent  && p.ReceiveUrgentNotifications)  ||
                        (notification.Urgency == UrgencyLevel.Normal  && p.ReceiveNormalNotifications)
                    ))
                .Select(p => p.UserId)
                .ToListAsync(cancellationToken);

            if (targetUserIds.Count == 0) return;

            var title = "New Blood Donation Request";
            var body  = $"Emergency blood needed at {notification.HospitalName}!";

            var data = new Dictionary<string, string>
            {
                { "type",           "NewDonationRequest"                  },
                { "requestId",      notification.RequestId.ToString()     },
                { "urgency",        notification.Urgency.ToString()       },
                { "bloodType",      notification.BloodType.ToString()     },
                { "hospitalName",   notification.HospitalName             },
                { "governorateId",  notification.GovernorateId.ToString() }
            };

            await _pushNotificationService.SendToUsersAsync(targetUserIds, title, body, data, cancellationToken);

            _logger.LogInformation(
                "Push notification sent for request {RequestId} to {Count} donors in governorate {GovernorateId}.",
                notification.RequestId, targetUserIds.Count, notification.GovernorateId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error sending push notification for request {RequestId}.", notification.RequestId);
        }
    }
}
