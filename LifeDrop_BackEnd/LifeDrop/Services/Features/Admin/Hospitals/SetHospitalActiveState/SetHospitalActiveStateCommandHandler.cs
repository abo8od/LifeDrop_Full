using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Hybrid;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;

namespace Services.Features.Admin.Hospitals.SetHospitalActiveState;

public class SetHospitalActiveStateCommandHandler
    : IRequestHandler<SetHospitalActiveStateCommand, Result<SetHospitalActiveStateResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly HybridCache _cache;
    private readonly ILogger<SetHospitalActiveStateCommandHandler> _logger;

    public SetHospitalActiveStateCommandHandler(
        IUnitOfWork unitOfWork,
        HybridCache cache,
        ILogger<SetHospitalActiveStateCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<SetHospitalActiveStateResult>> Handle(
        SetHospitalActiveStateCommand request,
        CancellationToken cancellationToken)
    {
        var hospital = await _unitOfWork.Hospitals
            .Query()
            .FirstOrDefaultAsync(h => h.Id == request.HospitalId, cancellationToken);

        if (hospital == null)
        {
            _logger.LogWarning(
                "SetHospitalActiveState failed: hospital {HospitalId} not found.",
                request.HospitalId);
            return Result<SetHospitalActiveStateResult>.Failure(HospitalErrors.NotFound);
        }

        if (request.IsActive)
            hospital.Verify();
        else
            hospital.Suspend();

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        await Task.WhenAll(
            _cache.RemoveByTagAsync("admin_hospitals", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_{request.HospitalId}", cancellationToken).AsTask()
        );

        _logger.LogInformation(
            "Hospital {HospitalId} set to IsActive={IsActive} by admin.",
            hospital.Id, hospital.IsVerified);

        return Result<SetHospitalActiveStateResult>.Success(
            new SetHospitalActiveStateResult(hospital.Id, hospital.IsVerified));
    }
}
