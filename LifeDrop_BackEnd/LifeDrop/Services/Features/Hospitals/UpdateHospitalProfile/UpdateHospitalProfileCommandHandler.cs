using System.Threading;
using System.Threading.Tasks;
using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

using Microsoft.Extensions.Caching.Hybrid;

namespace Services.Features.Hospitals.UpdateHospitalProfile;

public class UpdateHospitalProfileCommandHandler : IRequestHandler<UpdateHospitalProfileCommand, Result<UpdateHospitalProfileResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly HybridCache _cache;
    private readonly ILogger<UpdateHospitalProfileCommandHandler> _logger;

    public UpdateHospitalProfileCommandHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, HybridCache cache, ILogger<UpdateHospitalProfileCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _cache = cache;
        _logger = logger;
    }

    public async Task<Result<UpdateHospitalProfileResult>> Handle(UpdateHospitalProfileCommand request, CancellationToken cancellationToken)
    {
        if (!_currentUserService.HospitalId.HasValue)
        {
            _logger.LogWarning("Hospital profile update failed: no hospital context available.");
            return Result<UpdateHospitalProfileResult>.Failure(HospitalErrors.HospitalMismatch);
        }

        var hospitalId = _currentUserService.HospitalId.Value;

        var hospital = await _unitOfWork.Hospitals
            .Query()
            .FirstOrDefaultAsync(h => h.Id == hospitalId, cancellationToken);

        if (hospital == null)
        {
            _logger.LogWarning("Hospital profile update failed: hospital {HospitalId} not found.", hospitalId);
            return Result<UpdateHospitalProfileResult>.Failure(HospitalErrors.NotFound);
        }

        if (!string.IsNullOrWhiteSpace(request.Name))
        {
            hospital.Name = request.Name.Trim();
        }

        if (!string.IsNullOrWhiteSpace(request.Address))
        {
            hospital.Address = request.Address.Trim();
        }

        if (request.Latitude.HasValue)
        {
            hospital.Latitude = request.Latitude.Value;
        }

        if (request.Longitude.HasValue)
        {
            hospital.Longitude = request.Longitude.Value;
        }

        if (!string.IsNullOrWhiteSpace(request.PhoneNumber))
        {
            hospital.PhoneNumber = request.PhoneNumber.Trim();
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        // Fetch all active request IDs for this hospital to invalidate their specific caches
        var activeRequestIds = await _unitOfWork.DonationRequests
            .Query()
            .Where(r => r.HospitalId == hospitalId && r.Status == Core.Enums.RequestStatus.Active)
            .Select(r => r.Id)
            .ToListAsync(cancellationToken);

        var cacheTasks = new List<Task>
        {
            _cache.RemoveByTagAsync($"hospital_{hospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"dashboard_hospital_{hospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync($"hospital_requests_{hospitalId}", cancellationToken).AsTask(),
            _cache.RemoveByTagAsync("admin_hospitals", cancellationToken).AsTask()
        };

        foreach (var reqId in activeRequestIds)
        {
            cacheTasks.Add(_cache.RemoveByTagAsync($"request_{reqId}", cancellationToken).AsTask());
        }

        await Task.WhenAll(cacheTasks);

        _logger.LogInformation("Hospital {HospitalId} profile updated successfully.", hospitalId);

        return Result<UpdateHospitalProfileResult>.Success(new UpdateHospitalProfileResult(
            hospital.Id,
            hospital.Name,
            hospital.Address,
            hospital.PhoneNumber,
            hospital.Latitude,
            hospital.Longitude
        ));
    }
}
