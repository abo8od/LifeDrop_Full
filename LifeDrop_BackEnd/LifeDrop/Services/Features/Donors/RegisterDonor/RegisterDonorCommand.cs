using Core.Common;
using MediatR;

namespace Services.Features.Donors.RegisterDonor;

public record RegisterDonorCommand(
    string Email,
    string Password,
    string ConfirmPassword,
    string FirstName,
    string LastName,
    DateTime DateOfBirth,
    string BloodType,
    Guid? GovernorateId,
    Guid? DistrictId,
    string PhoneNumber
) : IRequest<Result<RegisterDonorResult>>;

public record RegisterDonorResult(Guid UserId, string Email);
