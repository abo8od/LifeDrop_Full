using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Hybrid;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;

namespace Services.Features.Admin.Hospitals.SetEmployeeActiveState;

public class SetEmployeeActiveStateCommandHandler
    : IRequestHandler<SetEmployeeActiveStateCommand, Result<SetEmployeeActiveStateResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly HybridCache _cache;
    private readonly ILogger<SetEmployeeActiveStateCommandHandler> _logger;

    public SetEmployeeActiveStateCommandHandler(
        IUnitOfWork unitOfWork,
        HybridCache cache,
        ILogger<SetEmployeeActiveStateCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<SetEmployeeActiveStateResult>> Handle(
        SetEmployeeActiveStateCommand request,
        CancellationToken cancellationToken)
    {
        var employeeProfile = await _unitOfWork.HospitalEmployeeProfiles
            .Query()
            .Include(ep => ep.User)
            .FirstOrDefaultAsync(ep => ep.Id == request.EmployeeProfileId, cancellationToken);

        if (employeeProfile == null)
        {
            _logger.LogWarning(
                "SetEmployeeActiveState failed: employee profile {EmployeeProfileId} not found.",
                request.EmployeeProfileId);
            return Result<SetEmployeeActiveStateResult>.Failure(HospitalErrors.EmployeeNotFound);
        }

        var user = employeeProfile.User;

        if (request.IsActive)
            user.Activate();
        else
            user.Deactivate();

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        await Task.WhenAll(
            _cache.RemoveByTagAsync($"employees_hospital_{employeeProfile.HospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync("admin_hospitals", cancellationToken).AsTask()
        );

        _logger.LogInformation(
            "Employee {EmployeeProfileId} (User {UserId}) set to IsActive={IsActive} by admin.",
            employeeProfile.Id, user.Id, user.IsActive);

        return Result<SetEmployeeActiveStateResult>.Success(
            new SetEmployeeActiveStateResult(employeeProfile.Id, user.IsActive));
    }
}
