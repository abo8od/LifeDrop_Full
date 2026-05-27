using Core.Common;
using Core.Enums;
using MediatR;

namespace Services.Features.DonationRequests.CreateDonationRequest;

public record CreateDonationRequestCommand(
    Guid HospitalId,
    BloodType BloodType,
    int TargetQuota,
    UrgencyLevel Urgency,
    List<Guid> TargetDistrictIds,
    DateTime? ExpiryDate
) : IRequest<Result<CreateDonationRequestResult>>;

public record CreateDonationRequestResult(
    Guid RequestId,
    int TargetQuota,
    string Status
);