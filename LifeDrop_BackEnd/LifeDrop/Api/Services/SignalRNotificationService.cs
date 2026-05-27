using Api.Hubs;
using Core.Helpers;
using Microsoft.AspNetCore.SignalR;
using Services.Features.DonationRequests.Events;
using Services.Interfaces;
using Shared.Notifications;

namespace Api.Services;

/// <summary>
/// SignalR-based notification service implementation.
/// Sends real-time notifications to compatible donors via SignalR groups.
/// </summary>
public class SignalRNotificationService : INotificationService
{
    private readonly IHubContext<DonationHub> _hubContext;
    private readonly ILogger<SignalRNotificationService> _logger;

    public SignalRNotificationService(
        IHubContext<DonationHub> hubContext,
        ILogger<SignalRNotificationService> logger)
    {
        _hubContext = hubContext;
        _logger = logger;
    }

    public async Task NotifyCompatibleDonorsAsync(
        DonationRequestCreatedEvent donationEvent,
        CancellationToken cancellationToken = default)
    {
        var governorateId = donationEvent.GovernorateId.ToString();
        var requiredBloodType = donationEvent.BloodType;

        // Get compatible donor blood types (who can donate to this required type)
        var compatibleDonorBloodTypes = requiredBloodType.GetCompatibleDonorBloodTypes();

        // Build the notification message
        var notification = new NewDonationRequestNotification
        {
            Title = "New Blood Donation Request",
            Body = $"Emergency blood needed at {donationEvent.HospitalName}!",
            Type = NotificationType.NewDonationRequest,
            RequestId = donationEvent.RequestId,
            HospitalName = donationEvent.HospitalName,
            GovernorateName = donationEvent.GovernorateName,
            RequiredBloodType = requiredBloodType,
            Urgency = donationEvent.Urgency,
            ExpiryDate = donationEvent.ExpiryDate
        };

        // Send to each compatible blood type group in the governorate
        foreach (var bloodType in compatibleDonorBloodTypes)
        {
            var groupName = $"Gov_{governorateId}_Blood_{bloodType}_{donationEvent.Urgency}";
            
            _logger.LogDebug(
                "Sending notification to group {GroupName} for request {RequestId}",
                groupName,
                donationEvent.RequestId);

            await _hubContext.Clients
                .Group(groupName)
                .SendAsync("NewDonationRequest", notification, cancellationToken);
        }

        _logger.LogInformation(
            "Notification sent for request {RequestId} to {Count} compatible groups in governorate {GovernorateId}",
            donationEvent.RequestId,
            compatibleDonorBloodTypes.Count(),
            governorateId);
    }

    public async Task NotifyUserAsync(
        Guid userId,
        NotificationMessage message,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation(
            "Sending notification to user {UserId}: {Title}",
            userId,
            message.Title);

        await _hubContext.Clients
            .User(userId.ToString())
            .SendAsync("Notification", message, cancellationToken);
    }

    public async Task NotifySlotReopenedAsync(
        DonationSlotReopenedEvent slotEvent,
        CancellationToken cancellationToken = default)
    {
        // We need to fetch the request details to get governorate and blood type
        // Since this is a notification service, we'll broadcast to broader groups
        // The handler will provide the necessary context via the event
        
        _logger.LogInformation(
            "Slot reopened for request {RequestId} - notifying potential donors",
            slotEvent.RequestId);

        // Send notification to compatible donors in the governorate
        var governorateId = slotEvent.GovernorateId.ToString();
        var requiredBloodType = slotEvent.RequiredBloodType;

        // Get compatible donor blood types
        var compatibleDonorBloodTypes = requiredBloodType.GetCompatibleDonorBloodTypes();

        var notification = new NewDonationRequestNotification
        {
            Title = "Donation Slot Reopened",
            Body = $"A slot has opened at {slotEvent.HospitalName}!",
            Type = NotificationType.SlotReopened,
            RequestId = slotEvent.RequestId,
            HospitalName = slotEvent.HospitalName,
            GovernorateName = slotEvent.GovernorateName,
            RequiredBloodType = requiredBloodType,
            Urgency = Core.Enums.UrgencyLevel.Normal,
            ExpiryDate = DateTimeOffset.UtcNow.AddHours(24)
        };

        foreach (var bloodType in compatibleDonorBloodTypes)
        {
            var groupName = $"Gov_{governorateId}_Blood_{bloodType}_{Core.Enums.UrgencyLevel.Normal}";

            _logger.LogDebug(
                "Sending slot reopen notification to group {GroupName}",
                groupName);

            await _hubContext.Clients
                .Group(groupName)
                .SendAsync("NewDonationRequest", notification, cancellationToken);
        }

        _logger.LogInformation(
            "Slot reopen notification sent for request {RequestId}",
            slotEvent.RequestId);
    }

    public async Task NotifyProfileUpdatedAsync(
        Guid userId,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Notifying user {UserId} about profile update for group refresh", userId);

        await _hubContext.Clients
            .User(userId.ToString())
            .SendAsync("ProfileUpdated", cancellationToken);
    }

    public Task NotifyHospitalRequestAcceptedAsync(
        Guid hospitalId,
        Shared.Notifications.RequestAcceptedNotification notification,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Hospital {HospitalId}: RequestAccepted for {RequestId}.", hospitalId, notification.RequestId);
        return _hubContext.Clients.Group($"Hospital_{hospitalId}")
            .SendAsync("RequestAccepted", notification, cancellationToken);
    }

    public Task NotifyHospitalRequestUpdatedAsync(
        Guid hospitalId,
        Shared.Notifications.RequestUpdatedNotification notification,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Hospital {HospitalId}: RequestUpdated for {RequestId} ({Count}/{Quota}).",
            hospitalId, notification.RequestId, notification.FulfilledCount, notification.TargetQuota);
        return _hubContext.Clients.Group($"Hospital_{hospitalId}")
            .SendAsync("RequestUpdated", notification, cancellationToken);
    }

    public Task NotifyHospitalDashboardUpdatedAsync(
        Guid hospitalId,
        Shared.Notifications.DashboardUpdatedNotification notification,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Hospital {HospitalId}: DashboardUpdated — active={Active}, fulfilled={Fulfilled}.",
            hospitalId, notification.ActiveRequests, notification.FulfilledRequests);
        return _hubContext.Clients.Group($"Hospital_{hospitalId}")
            .SendAsync("DashboardUpdated", notification, cancellationToken);
    }

    public Task NotifyHospitalAcceptanceUpdatedAsync(
        Guid hospitalId,
        Shared.Notifications.AcceptanceUpdatedNotification notification,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Hospital {HospitalId}: AcceptanceUpdated {AcceptanceId} → {Status}.",
            hospitalId, notification.AcceptanceId, notification.Status);
        return _hubContext.Clients.Group($"Hospital_{hospitalId}")
            .SendAsync("AcceptanceUpdated", notification, cancellationToken);
    }

    public Task NotifyDonorActiveDonationAsync(
        Guid donorUserId,
        Shared.Notifications.ActiveDonationNotification notification,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Donor {DonorUserId}: ActiveDonationUpdated {AcceptanceId} → {Status}.",
            donorUserId, notification.AcceptanceId, notification.Status);
        return _hubContext.Clients.User(donorUserId.ToString())
            .SendAsync("ActiveDonationUpdated", notification, cancellationToken);
    }
}