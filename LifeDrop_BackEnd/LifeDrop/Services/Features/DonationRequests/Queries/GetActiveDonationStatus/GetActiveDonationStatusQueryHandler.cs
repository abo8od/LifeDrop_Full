using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.DonationRequests.Queries.GetActiveDonationStatus;

public class GetActiveDonationStatusQueryHandler : IRequestHandler<GetActiveDonationStatusQuery, Result<ActiveDonationStatusDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetActiveDonationStatusQueryHandler> _logger;
    private const int TimeoutMinutes = 120; // 2 hours

    public GetActiveDonationStatusQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetActiveDonationStatusQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<ActiveDonationStatusDto>> Handle(GetActiveDonationStatusQuery request, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;

        // Find the donor's active acceptance
        var activeAcceptance = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonorProfile.UserId == userId && a.Status == AcceptanceStatus.Accepted)
            .Select(a => new ActiveDonationStatusDto
            {
                AcceptanceId = a.Id,
                RequestId = a.DonationRequestId,
                HospitalName = a.DonationRequest.Hospital.Name,
                HospitalAddress = a.DonationRequest.Hospital.Address,
                HospitalPhoneNumber = a.DonationRequest.Hospital.PhoneNumber,
                HospitalLatitude = a.DonationRequest.Hospital.Latitude,
                HospitalLongitude = a.DonationRequest.Hospital.Longitude,
                RequiredBloodType = a.DonationRequest.BloodType.ToString(),
                Urgency = a.DonationRequest.Urgency.ToString(),
                UnitsRequested = a.DonationRequest.TargetQuota,
                Status = a.Status.ToString(),
                AcceptedAt = a.AcceptedAt
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (activeAcceptance == null)
        {
            return Result<ActiveDonationStatusDto>.Failure(DonationErrors.NoActiveDonation);
        }

        // Calculate remaining time and round to nearest integer
        var elapsed = DateTime.UtcNow - activeAcceptance.AcceptedAt;
        activeAcceptance.RemainingMinutes = (int)Math.Max(0, Math.Round(TimeoutMinutes - elapsed.TotalMinutes));

        return Result<ActiveDonationStatusDto>.Success(activeAcceptance);
    }
}
