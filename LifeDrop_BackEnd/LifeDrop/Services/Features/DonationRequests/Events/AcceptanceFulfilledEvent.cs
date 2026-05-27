using Core.Common;
using Core.Enums;

namespace Services.Features.DonationRequests.Events;

public record AcceptanceFulfilledEvent(
    Guid RequestId,
    Guid AcceptanceId,
    Guid HospitalId,
    Guid DonorUserId,
    RequestStatus RequestStatus,
    int CurrentFulfilledAcceptances,
    int TargetQuota) : IDomainEvent;
