using Core.Common;
using MediatR;

namespace Services.Features.Admin.Hospitals.SetEmployeeActiveState;

public record SetEmployeeActiveStateCommand(Guid EmployeeProfileId, bool IsActive)
    : IRequest<Result<SetEmployeeActiveStateResult>>;

public record SetEmployeeActiveStateResult(Guid EmployeeProfileId, bool IsActive);
