using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.Hospitals.GetHospitalProfile;
using Services.Interfaces;
using Microsoft.Extensions.Logging;
using AcceptanceStatus = Core.Enums.AcceptanceStatus;
using RequestStatus = Core.Enums.RequestStatus;

namespace Services.Features.Hospitals.GetHospitalProfile;

public class GetHospitalProfileQueryHandler : IRequestHandler<GetHospitalProfileQuery, Result<HospitalProfileDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetHospitalProfileQueryHandler> _logger;

    public GetHospitalProfileQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetHospitalProfileQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<HospitalProfileDto>> Handle(GetHospitalProfileQuery request, CancellationToken cancellationToken)
    {
        var hospitalId = request.HospitalId;

        var hospital = await _unitOfWork.Hospitals
            .Query()
            .AsNoTracking()
            .Where(h => h.Id == hospitalId)
            .Select(h => new
            {
                h.Id,
                h.Name,
                h.Latitude,
                h.Longitude,
                h.Address,
                h.PhoneNumber,
                h.IsVerified
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (hospital == null)
        {
            _logger.LogWarning("Get hospital profile failed: hospital {HospitalId} not found.", hospitalId);
            return Result<HospitalProfileDto>.Failure(HospitalErrors.NotFound);
        }

        // Get statistics using grouped queries to avoid N+1 and minimize DB roundtrips
        var requestStats = await _unitOfWork.DonationRequests
            .Query()
            .Where(r => r.HospitalId == hospitalId)
            .GroupBy(r => 1)
            .Select(g => new 
            {
                Total = g.Count(),
                Active = g.Count(r => r.Status == RequestStatus.Active),
                Fulfilled = g.Count(r => r.Status == RequestStatus.Fulfilled),
                Cancelled = g.Count(r => r.Status == RequestStatus.Cancelled)
            })
            .FirstOrDefaultAsync(cancellationToken);

        var totalRequests = requestStats?.Total ?? 0;
        var activeRequests = requestStats?.Active ?? 0;
        var fulfilledRequests = requestStats?.Fulfilled ?? 0;
        var cancelledRequests = requestStats?.Cancelled ?? 0;

        var totalEmployees = await _unitOfWork.HospitalEmployeeProfiles
            .Query()
            .AsNoTracking()
            .CountAsync(ep => ep.HospitalId == hospitalId, cancellationToken);

        var acceptanceStats = await _unitOfWork.DonationAcceptances
            .Query()
            .AsNoTracking()
            .Where(a => a.DonationRequest!.HospitalId == hospitalId)
            .GroupBy(a => 1)
            .Select(g => new 
            {
                TotalDonorsServed = g.Count(a => a.Status == AcceptanceStatus.Fulfilled),
                NoShows = g.Count(a => a.Status == AcceptanceStatus.NoShow)
            })
            .FirstOrDefaultAsync(cancellationToken);

        var totalDonorsServed = acceptanceStats?.TotalDonorsServed ?? 0;
        var noShows = acceptanceStats?.NoShows ?? 0;

        // Calculate rates (avoid division by zero)
        var totalCompleted = totalRequests > 0 ? (double)fulfilledRequests / totalRequests * 100 : 0;
        var noShowRate = totalDonorsServed + noShows > 0 
            ? (double)noShows / (totalDonorsServed + noShows) * 100 
            : 0;

        var dto = new HospitalProfileDto
        {
            HospitalId = hospital.Id,
            Name = hospital.Name,
            Latitude = hospital.Latitude,
            Longitude = hospital.Longitude,
            Address = hospital.Address,
            PhoneNumber = hospital.PhoneNumber,
            IsVerified = hospital.IsVerified,
            TotalRequests = totalRequests,
            ActiveRequests = activeRequests,
            FulfilledRequests = fulfilledRequests,
            CancelledRequests = cancelledRequests,
            TotalEmployees = totalEmployees,
            TotalDonorsServed = totalDonorsServed,
            TotalNoShows = noShows,
            FulfillmentRate = Math.Round(totalCompleted, 2),
            NoShowRate = Math.Round(noShowRate, 2)
        };

        return Result<HospitalProfileDto>.Success(dto);
    }
}