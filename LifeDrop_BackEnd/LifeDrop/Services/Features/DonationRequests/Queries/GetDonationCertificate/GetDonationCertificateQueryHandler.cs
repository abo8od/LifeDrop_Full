using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using LifeDrop.Services.Abstractions;
using LifeDrop.Services.DTOs;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.DonationRequests.Queries.GetDonationCertificate;

public class GetDonationCertificateQueryHandler : IRequestHandler<GetDonationCertificateQuery, Result<byte[]>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPdfCertificateGenerator _pdfGenerator;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetDonationCertificateQueryHandler> _logger;

    public GetDonationCertificateQueryHandler(
        IUnitOfWork unitOfWork,
        IPdfCertificateGenerator pdfGenerator,
        ICurrentUserService currentUserService,
        ILogger<GetDonationCertificateQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _pdfGenerator = pdfGenerator;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<byte[]>> Handle(GetDonationCertificateQuery request, CancellationToken cancellationToken)
    {
        var acceptance = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Include(a => a.DonorProfile)
                .ThenInclude(dp => dp.User)
            .Include(a => a.DonationRequest)
                .ThenInclude(r => r.Hospital)
            .FirstOrDefaultAsync(a => 
                a.DonationRequestId == request.RequestId && 
                a.DonorProfile.UserId == _currentUserService.UserId, 
                cancellationToken);

        if (acceptance == null)
        {
            _logger.LogWarning("Certificate generation failed: acceptance not found for request {RequestId} and user {UserId}.", request.RequestId, _currentUserService.UserId);
            return Result<byte[]>.Failure(DonationErrors.AcceptanceNotFound);
        }

        if (acceptance.Status != AcceptanceStatus.Fulfilled)
        {
            _logger.LogWarning("Certificate generation failed: acceptance {AcceptanceId} is not fulfilled (Status: {Status}).", acceptance.Id, acceptance.Status);
            return Result<byte[]>.Failure(DonationErrors.CertificateInvalidState);
        }

        var dto = new CertificateDataDto
        {
            DonorName = $"{acceptance.DonorProfile.User.FirstName} {acceptance.DonorProfile.User.LastName}",
            BloodType = acceptance.DonationRequest.BloodType.ToString(),
            HospitalName = acceptance.DonationRequest.Hospital.Name,
            Date = acceptance.FulfilledAt ?? acceptance.ModifiedOn.DateTime,
            CertificateId = acceptance.Id.ToString()
        };

        var pdfBytes = _pdfGenerator.Generate(dto);
        return Result<byte[]>.Success(pdfBytes);
    }
}