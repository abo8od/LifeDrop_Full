using Core.Common;
using MediatR;

namespace Services.Features.Admin.Hospitals.SetHospitalActiveState;

public record SetHospitalActiveStateCommand(Guid HospitalId, bool IsActive)
    : IRequest<Result<SetHospitalActiveStateResult>>;

public record SetHospitalActiveStateResult(Guid HospitalId, bool IsActive);
