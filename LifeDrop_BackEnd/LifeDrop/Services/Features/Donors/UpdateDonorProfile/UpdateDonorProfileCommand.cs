using Core.Common;
using MediatR;

namespace Services.Features.Donors.UpdateDonorProfile;

public record UpdateDonorProfileCommand(
    string? FirstName,
    string? LastName,
    string? PhoneNumber,
    string? BloodType,
    bool? IsAvailable,
    Guid? GovernorateId,
    Guid? DistrictId,
    bool? ReceiveCriticalNotifications,
    bool? ReceiveUrgentNotifications,
    bool? ReceiveNormalNotifications
) : IRequest<Result<UpdateDonorProfileResult>>;

public record UpdateDonorProfileResult(
    string? FirstName,
    string? LastName,
    string? PhoneNumber,
    string? BloodType,
    bool? IsAvailable,
    Guid? GovernorateId,
    Guid? DistrictId,
    bool? ReceiveCriticalNotifications,
    bool? ReceiveUrgentNotifications,
    bool? ReceiveNormalNotifications
);