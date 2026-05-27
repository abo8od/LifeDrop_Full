using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Features.DonationRequests.Queries.GetHospitalRequestDetails;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.DonationRequests.Queries.GetHospitalRequestDetails;

/// <summary>
/// Handler for GetHospitalRequestDetailsQuery.
/// Retrieves detailed donation request with acceptances for hospital staff.
/// Uses LINQ Select projections for optimized database queries.
/// </summary>
public class GetHospitalRequestDetailsQueryHandler : IRequestHandler<GetHospitalRequestDetailsQuery, Result<HospitalRequestDetailsDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetHospitalRequestDetailsQueryHandler> _logger;

    public GetHospitalRequestDetailsQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetHospitalRequestDetailsQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<HospitalRequestDetailsDto>> Handle(GetHospitalRequestDetailsQuery request, CancellationToken cancellationToken)
    {
        // Ensure hospital ID is available
        if (!_currentUserService.HospitalId.HasValue)
        {
            _logger.LogWarning("Get request details failed: no hospital context available for user {UserId}.", _currentUserService.UserId);
                return Result<HospitalRequestDetailsDto>.Failure(HospitalErrors.HospitalMismatch);
        }

        var hospitalId = _currentUserService.HospitalId.Value;

        // Get the request and verify it belongs to this hospital
        var donationRequest = await _unitOfWork.DonationRequests
            .Query()
            .AsNoTracking()
            .Where(r => r.Id == request.RequestId && r.HospitalId == hospitalId)
            .Select(r => new HospitalRequestDetailsDto
            {
                RequestId = r.Id,
                HospitalName = r.Hospital!.Name,
                BloodType = r.BloodType.ToString(),
                TargetQuota = r.TargetQuota,
                CurrentActiveAcceptances = r.CurrentActiveAcceptances,
                CurrentFulfilledAcceptances = r.CurrentFulfilledAcceptances,
                Urgency = r.Urgency.ToString(),
                Status = r.Status.ToString(),
                CreatedOn = r.CreatedOn,
                ExpiryDate = r.ExpiryDate,
                Latitude = r.Hospital!.Latitude,
                Longitude = r.Hospital.Longitude,
                HospitalAddress = r.Hospital.Address,
                TargetDistricts = r.RequestDistricts.Select(rd => rd.District!.Name).ToList(),
                Acceptances = r.Acceptances
                    .Where(a => a.Status == AcceptanceStatus.Accepted || a.Status == AcceptanceStatus.Fulfilled)
                    .Select(a => new AcceptedDonorDto
                    {
                        AcceptanceId = a.Id,
                        DonorName = a.DonorProfile!.User!.FirstName + " " + a.DonorProfile.User.LastName,
                        PhoneNumber = a.DonorProfile.User.PhoneNumber,
                        BloodType = (a.DonorProfile.BloodType ?? BloodType.O_Positive).ToString(),
                        IsMedicallyVerified = a.DonorProfile.IsMedicallyVerified,
                        Status = a.Status.ToString(),
                        AcceptedAt = a.AcceptedAt
                    })
                    .OrderByDescending(a => a.AcceptedAt)
                    .Take(100)
                    .ToList()
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (donationRequest == null)
        {
            _logger.LogWarning("Get request details failed: request {RequestId} not found or not owned by hospital {HospitalId}.", request.RequestId, hospitalId);
                return Result<HospitalRequestDetailsDto>.Failure(DonationErrors.RequestNotFound);
        }

        return Result<HospitalRequestDetailsDto>.Success(donationRequest);
    }
}