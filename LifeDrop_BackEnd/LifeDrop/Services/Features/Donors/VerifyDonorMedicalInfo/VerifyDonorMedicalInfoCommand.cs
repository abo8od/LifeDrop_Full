using Core.Common;
using MediatR;

namespace Services.Features.Donors.VerifyDonorMedicalInfo;

public record VerifyDonorMedicalInfoCommand(Guid DonorUserId) : IRequest<Result<VerifyDonorMedicalInfoResult>>;

public record VerifyDonorMedicalInfoResult(Guid DonorUserId, bool IsMedicallyVerified);
