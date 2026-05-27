using Core.Common;
using Core.Common.Errors;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Responses;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.GetDonationHistory;

public class GetDonationHistoryQueryHandler : IRequestHandler<GetDonationHistoryQuery, Result<PagedResponse<DonationHistoryDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetDonationHistoryQueryHandler> _logger;

    public GetDonationHistoryQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetDonationHistoryQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<PagedResponse<DonationHistoryDto>>> Handle(GetDonationHistoryQuery request, CancellationToken cancellationToken)
    {
        var userId = request.UserId;
        var pageNumber = request.PageNumber ?? 1;
        var pageSize = request.PageSize ?? 10;

        // Verify the profile exists first to return a proper 404 if needed
        var profileExists = await _unitOfWork.DonorProfiles.Query()
            .AsNoTracking()
            .AnyAsync(p => p.UserId == userId, cancellationToken);

        if (!profileExists)
        {
            _logger.LogWarning("Donation history failed: donor profile not found for user {UserId}.", userId);
            return Result<PagedResponse<DonationHistoryDto>>.Failure(DonorErrors.NotFound);
        }

        // Query directly via navigation property — no need to fetch the profile's Id separately
        var query = _unitOfWork.DonationAcceptances.Query()
            .AsNoTracking()
            .Where(a => a.DonorProfile.UserId == userId)
            .OrderByDescending(a => a.AcceptedAt)
            .Select(a => new DonationHistoryDto(
                a.Id,
                a.DonationRequestId,
                a.DonationRequest.Hospital.Name,
                a.DonationRequest.BloodType.ToString(),
                a.FulfilledAt ?? a.AcceptedAt,
                a.Status.ToString(),
                a.Status == AcceptanceStatus.Fulfilled ? 50 : 0
            ));

        var count = await query.CountAsync(cancellationToken);
        var items = await query
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return Result<PagedResponse<DonationHistoryDto>>.Success(
            new PagedResponse<DonationHistoryDto>(items, count, pageNumber, pageSize)
        );
    }
}
