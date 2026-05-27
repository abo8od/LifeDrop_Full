using Core.Common;

namespace Services.Features.DonationRequests.Events;

public record AcceptanceNoShowEvent(
    Guid RequestId,
    Guid AcceptanceId,
    Guid HospitalId,
    Guid DonorUserId,
    int CurrentActiveAcceptances,
    int TargetQuota) : IDomainEvent;
