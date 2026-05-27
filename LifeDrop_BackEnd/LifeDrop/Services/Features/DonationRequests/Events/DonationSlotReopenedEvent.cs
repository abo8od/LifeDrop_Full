using Core.Common;
using Core.Enums;
using MediatR;

namespace Services.Features.DonationRequests.Events;

/// <summary>
/// Event raised when a donation slot is reopened (donor cancels or no-show).
/// Triggers real-time notifications to potential substitute donors.
/// </summary>
public record DonationSlotReopenedEvent(
    Guid RequestId,
    Guid GovernorateId,
    string GovernorateName,
    BloodType RequiredBloodType,
    string HospitalName) : IDomainEvent;