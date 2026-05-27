using Core.Common;

namespace Services.Features.DonationRequests.Events;

public record AcceptanceCancelledByDonorEvent(
    Guid RequestId,
    Guid AcceptanceId,
    Guid HospitalId,
    Guid DonorUserId,
    int CurrentActiveAcceptances,
    int TargetQuota) : IDomainEvent;
