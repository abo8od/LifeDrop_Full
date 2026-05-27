using Core.Common;
using Core.Common.Errors;
using MediatR;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Shared.Responses;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.GetGamificationHistory;

public class GetGamificationHistoryQueryHandler : IRequestHandler<GetGamificationHistoryQuery, Result<PagedResponse<GamificationHistoryDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<GetGamificationHistoryQueryHandler> _logger;

    public GetGamificationHistoryQueryHandler(IUnitOfWork unitOfWork, ICurrentUserService currentUserService, ILogger<GetGamificationHistoryQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<Result<PagedResponse<GamificationHistoryDto>>> Handle(GetGamificationHistoryQuery request, CancellationToken cancellationToken)
    {
        var userId = request.UserId;
        var pageNumber = request.PageNumber ?? 1;
        var pageSize = request.PageSize ?? 10;

        // 1. Quick check for profile existence (AsNoTracking for performance)
        var profileExists = await _unitOfWork.DonorProfiles.Query()
            .AsNoTracking()
            .AnyAsync(d => d.UserId == userId, cancellationToken);

        if (!profileExists)
        {
            _logger.LogWarning("Gamification history failed: donor profile not found for user {UserId}.", userId);
            return Result<PagedResponse<GamificationHistoryDto>>.Failure(DonorErrors.NotFound);
        }

        // 2. Query transactions using navigation property to avoid needing the ProfileId separately
        var query = _unitOfWork.PointTransactions.Query()
            .AsNoTracking()
            .Where(pt => pt.DonorProfile.UserId == userId)
            .OrderByDescending(pt => pt.CreatedOn)
            .Select(pt => new GamificationHistoryDto(
                pt.Id,
                pt.Points,
                pt.ActionType,
                pt.Description,
                pt.CreatedOn
            ));

        var count = await query.CountAsync(cancellationToken);
        var items = await query
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        var pagedResponse = new PagedResponse<GamificationHistoryDto>(items, count, pageNumber, pageSize);

        return Result<PagedResponse<GamificationHistoryDto>>.Success(pagedResponse);
    }
}
