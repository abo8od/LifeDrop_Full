using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.GetLeaderboard;

/// <summary>
/// Handler for GetLeaderboardQuery.
/// Retrieves top donors ordered by gamification points and reliability score.
/// Uses EF Core projections for optimized database queries.
/// </summary>
public class GetLeaderboardQueryHandler : IRequestHandler<GetLeaderboardQuery, Result<LeaderboardResponseDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<GetLeaderboardQueryHandler> _logger;

    public GetLeaderboardQueryHandler(IUnitOfWork unitOfWork, ILogger<GetLeaderboardQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<Result<LeaderboardResponseDto>> Handle(
    GetLeaderboardQuery request,
    CancellationToken cancellationToken)
    {
        string scope = "National";

        if (request.GovernorateId.HasValue)
        {
            var governorate = await _unitOfWork.Governorates
                .Query()
                .Where(g => g.Id == request.GovernorateId.Value)
                .Select(g => g.Name)
                .FirstOrDefaultAsync(cancellationToken);

            if (governorate == null)
            {
                _logger.LogWarning("Leaderboard retrieval failed: governorate {GovernorateId} not found.", request.GovernorateId.Value);
                return Result<LeaderboardResponseDto>.Failure(LocationErrors.GovernorateNotFound);
            }

            scope = governorate;
        }
        
        var query = _unitOfWork.DonorProfiles
            .Query()
            .AsNoTracking();

        if (request.GovernorateId.HasValue)
        {
            query = query.Where(d => d.GovernorateId == request.GovernorateId.Value);
        }

        var totalCount = await query.CountAsync(cancellationToken);

        var entries = await query
            .OrderByDescending(d => d.GamificationPoints)
            .ThenByDescending(d => d.ReliabilityScore)
            .Take(request.TopN)
            .Select(d => new LeaderboardEntryDto
            {
                DonorId = d.Id,
                FullName = d.User != null ? d.User.FirstName + " " + d.User.LastName : "Unknown",
                GovernorateName = d.Governorate != null ? d.Governorate.Name : "Unknown",
                GamificationPoints = d.GamificationPoints,
                ReliabilityScore = d.ReliabilityScore
            })
            .ToListAsync(cancellationToken);

        var rankedEntries = entries
            .Select((e, index) => new LeaderboardEntryDto
            {
                DonorId = e.DonorId,
                FullName = e.FullName,
                GovernorateName = e.GovernorateName,
                GamificationPoints = e.GamificationPoints,
                ReliabilityScore = e.ReliabilityScore,
                Rank = index + 1
            })
            .ToList();
        
        return Result<LeaderboardResponseDto>.Success(new LeaderboardResponseDto
        {
            Entries = rankedEntries,
            TotalCount = totalCount,
            Scope = scope
        });
    }
}