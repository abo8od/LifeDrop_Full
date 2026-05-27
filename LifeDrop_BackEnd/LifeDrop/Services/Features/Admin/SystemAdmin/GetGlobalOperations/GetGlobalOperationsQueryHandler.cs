using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Core.Common;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;

namespace Services.Features.Admin.SystemAdmin.GetGlobalOperations;

public class GetGlobalOperationsQueryHandler : IRequestHandler<GetGlobalOperationsQuery, Result<GlobalOperationsDto>>
{
    private readonly IUnitOfWork _unitOfWork;

    public GetGlobalOperationsQueryHandler(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<GlobalOperationsDto>> Handle(GetGlobalOperationsQuery request, CancellationToken cancellationToken)
    {
        // Execute 5 fast COUNT queries - each is a simple index-only scan, typically < 5ms each
        var totalHospitals = await _unitOfWork.Hospitals.Query()
            .AsNoTracking()
            .CountAsync(cancellationToken);

        var totalDonors = await _unitOfWork.DonorProfiles.Query()
            .AsNoTracking()
            .CountAsync(cancellationToken);

        var totalRequests = await _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .CountAsync(cancellationToken);

        var totalBags = await _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .CountAsync(a => a.Status == AcceptanceStatus.Fulfilled, cancellationToken);

        // Project to (requestId, governorate) pairs, deduplicate, then count per governorate.
        // Distinct before GroupBy avoids double-counting requests that target multiple districts
        // in the same governorate, and produces a cleaner COUNT(*) rather than COUNT(DISTINCT ...).
        var requestsByGovernorate = await _unitOfWork.DonationRequests.Query()
            .AsNoTracking()
            .SelectMany(r => r.RequestDistricts)
            .Select(rd => new { rd.DonationRequestId, GovernorateNameAr = rd.District.Governorate.NameAr })
            .Distinct()
            .GroupBy(x => x.GovernorateNameAr)
            .Select(g => new GovernorateStatDto(g.Key, g.Count()))
            .ToListAsync(cancellationToken);

        return Result<GlobalOperationsDto>.Success(new GlobalOperationsDto(
            totalHospitals,
            totalDonors,
            totalRequests,
            totalBags,
            requestsByGovernorate
        ));
    }
}
