using Core.Common;
using Core.Enums;

namespace Services.Features.DonationRequests.Events;

public record DonationAcceptedByDonorEvent(
    Guid RequestId,
    Guid AcceptanceId,
    Guid HospitalId,
    Guid DonorUserId,
    string DonorFullName,
    BloodType BloodType,
    DateTime AcceptedAt,
    RequestStatus RequestStatus,
    int CurrentActiveAcceptances,
    int TargetQuota) : IDomainEvent;
