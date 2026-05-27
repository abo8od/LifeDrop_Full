using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Responses;

namespace Services.Features.Hospitals.GetDonorCommunication;

public class GetDonorCommunicationQueryHandler : IRequestHandler<GetDonorCommunicationQuery, Result<PagedResponse<DonorInteractionDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;

    public GetDonorCommunicationQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
    }

    public async Task<Result<PagedResponse<DonorInteractionDto>>> Handle(GetDonorCommunicationQuery request, CancellationToken cancellationToken)
    {
        var hospitalId = request.HospitalId;


        var donorInteractionsQuery = _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonationRequest.HospitalId == hospitalId)
            .GroupBy(a => a.DonorProfileId)
            .Select(g => new
            {
                DonorId = g.Key,
                // Accessing properties via the first element of the group is more efficient than Max() on strings
                DonorInfo = g.Select(a => new { 
                    a.DonorProfile.User.FirstName, 
                    a.DonorProfile.User.LastName, 
                    a.DonorProfile.User.PhoneNumber,
                    BloodType = a.DonorProfile.BloodType,
                    a.DonorProfile.IsMedicallyVerified
                }).FirstOrDefault(),
                LastInteractionDate = g.Max(a => a.FulfilledAt ?? a.AcceptedAt),
                TotalDonationsToHospital = g.Count(a => a.Status == AcceptanceStatus.Fulfilled),
                LatestStatus = g.OrderByDescending(a => a.AcceptedAt).Select(a => a.Status).FirstOrDefault()
            });

        var count = await donorInteractionsQuery.CountAsync(cancellationToken);
        
        var pagedData = await donorInteractionsQuery
            .OrderByDescending(d => d.LastInteractionDate)
            .Skip(((request.PageNumber ?? 1) - 1) * (request.PageSize ?? 10))
            .Take(request.PageSize ?? 10)
            .ToListAsync(cancellationToken);

        var result = pagedData.Select(d => new DonorInteractionDto(
            d.DonorId,
            $"{d.DonorInfo?.FirstName} {d.DonorInfo?.LastName}",
            d.DonorInfo?.PhoneNumber ?? "N/A",
            (d.DonorInfo?.BloodType ?? BloodType.O_Positive).ToString(),
            new DateTimeOffset(d.LastInteractionDate, TimeSpan.Zero),
            d.TotalDonationsToHospital,
            d.LatestStatus.ToString(),
            d.DonorInfo?.IsMedicallyVerified ?? false
        )).ToList();

        var pagedResponse = new PagedResponse<DonorInteractionDto>(
            result,
            count,
            request.PageNumber ?? 1,
            request.PageSize ?? 10
        );

        return Result<PagedResponse<DonorInteractionDto>>.Success(pagedResponse);
    }
}
