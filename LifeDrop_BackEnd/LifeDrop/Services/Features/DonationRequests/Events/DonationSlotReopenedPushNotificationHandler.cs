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
/// Sends FCM/APNs push notifications to compatible donors when a donation slot reopens.
/// </summary>
public class DonationSlotReopenedPushNotificationHandler : INotificationHandler<DonationSlotReopenedEvent>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPushNotificationService _pushNotificationService;
    private readonly DonationSettings _donationSettings;
    private readonly ILogger<DonationSlotReopenedPushNotificationHandler> _logger;

    public DonationSlotReopenedPushNotificationHandler(
        IUnitOfWork unitOfWork,
        IPushNotificationService pushNotificationService,
        IOptions<DonationSettings> donationSettings,
        ILogger<DonationSlotReopenedPushNotificationHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _pushNotificationService = pushNotificationService;
        _donationSettings = donationSettings.Value;
        _logger = logger;
    }

    public async Task Handle(DonationSlotReopenedEvent notification, CancellationToken cancellationToken)
    {
        try
        {
            var compatibleDonorBloodTypes = notification.RequiredBloodType
                .GetCompatibleDonorBloodTypes()
                .ToList();
            var cooldownCutoff = DateTimeOffset.UtcNow.AddDays(-_donationSettings.CooldownDays);

            // Slot reopened is time-sensitive — include donors who have Urgent OR Normal enabled
            var targetUserIds = await _unitOfWork.DonorProfiles
                .Query()
                .AsNoTracking()
                .Where(p =>
                    p.GovernorateId == notification.GovernorateId &&
                    p.IsAvailable &&
                    p.BloodType.HasValue &&
                    compatibleDonorBloodTypes.Contains(p.BloodType.Value) &&
                    (!p.LastDonationDate.HasValue || p.LastDonationDate.Value <= cooldownCutoff) &&
                    (p.ReceiveUrgentNotifications || p.ReceiveNormalNotifications))
                .Select(p => p.UserId)
                .ToListAsync(cancellationToken);

            if (targetUserIds.Count == 0) return;

            var title = "Donation Slot Available";
            var body  = $"A slot has reopened at {notification.HospitalName}. Can you help?";

            var data = new Dictionary<string, string>
            {
                { "type",          "SlotReopened"                            },
                { "requestId",     notification.RequestId.ToString()         },
                { "bloodType",     notification.RequiredBloodType.ToString() },
                { "hospitalName",  notification.HospitalName                 }
            };

            const int maxAttempts = 3;
            for (var attempt = 1; attempt <= maxAttempts; attempt++)
            {
                try
                {
                    await _pushNotificationService.SendToUsersAsync(targetUserIds, title, body, data, cancellationToken);
                    _logger.LogInformation(
                        "Slot-reopened push notification sent for request {RequestId} to {Count} donors.",
                        notification.RequestId, targetUserIds.Count);
                    break;
                }
                catch (Exception ex) when (attempt < maxAttempts)
                {
                    _logger.LogWarning(ex,
                        "Slot-reopened push notification attempt {Attempt}/{Max} failed for request {RequestId}. Retrying.",
                        attempt, maxAttempts, notification.RequestId);
                    await Task.Delay(TimeSpan.FromMilliseconds(500 * attempt), cancellationToken);
                }
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error sending slot-reopened push notification for request {RequestId}.", notification.RequestId);
        }
    }
}
