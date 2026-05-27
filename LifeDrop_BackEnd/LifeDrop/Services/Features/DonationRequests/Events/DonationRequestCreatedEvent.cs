using Core.Common;
using Core.Enums;
using MediatR;
using Shared.Notifications;

namespace Services.Features.DonationRequests.Events;

/// <summary>
/// Event published when a new donation request is created.
/// Used to trigger notifications to compatible donors via SignalR.
/// </summary>
public class DonationRequestCreatedEvent : IDomainEvent
{
    public Guid RequestId { get; init; }
    public string HospitalName { get; init; } = string.Empty;
    public Guid HospitalId { get; init; }
    public Guid GovernorateId { get; init; }
    public string GovernorateName { get; init; } = string.Empty;
    public BloodType BloodType { get; init; }
    public UrgencyLevel Urgency { get; init; }
    public int TargetQuota { get; init; }
    public DateTimeOffset ExpiryDate { get; init; }
}