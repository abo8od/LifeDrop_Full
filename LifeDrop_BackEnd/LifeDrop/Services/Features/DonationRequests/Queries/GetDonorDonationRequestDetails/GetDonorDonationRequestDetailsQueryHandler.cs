using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.DonationRequests.Queries.GetDonorDonationRequestDetails;

public class GetDonorDonationRequestDetailsQueryHandler : IRequestHandler<GetDonorDonationRequestDetailsQuery, Result<DonorDonationRequestDetailsDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetDonorDonationRequestDetailsQueryHandler> _logger;

    public GetDonorDonationRequestDetailsQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetDonorDonationRequestDetailsQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<DonorDonationRequestDetailsDto>> Handle(GetDonorDonationRequestDetailsQuery request, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;

        var result = await _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .Where(r => r.Id == request.RequestId)
            .Select(r => new DonorDonationRequestDetailsDto
            {
                RequestId = r.Id,
                HospitalName = r.Hospital.Name,
                HospitalAddress = r.Hospital.Address,
                HospitalLatitude = r.Hospital.Latitude,
                HospitalLongitude = r.Hospital.Longitude,
                HospitalPhoneNumber = r.Hospital.PhoneNumber,
                RequiredBloodType = r.BloodType.ToString(),
                Urgency = r.Urgency.ToString(),
                Status = r.Status.ToString(),
                ExpiryDate = r.ExpiryDate,
                IsAcceptedByCurrentUser = r.Acceptances.Any(a => a.DonorProfile.UserId == userId),
                CurrentUserAcceptanceStatus = r.Acceptances
                    .Where(a => a.DonorProfile.UserId == userId)
                    .Select(a => a.Status.ToString())
                    .FirstOrDefault(),
                AcceptedAt = r.Acceptances
                    .Where(a => a.DonorProfile.UserId == userId && a.Status == AcceptanceStatus.Accepted)
                    .Select(a => (DateTime?)a.AcceptedAt)
                    .FirstOrDefault()
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (result == null)
        {
            _logger.LogWarning("Get donor request details failed: request {RequestId} not found.", request.RequestId);
            return Result<DonorDonationRequestDetailsDto>.Failure(DonationErrors.RequestNotFound);
        }

        return Result<DonorDonationRequestDetailsDto>.Success(result);
    }
}
