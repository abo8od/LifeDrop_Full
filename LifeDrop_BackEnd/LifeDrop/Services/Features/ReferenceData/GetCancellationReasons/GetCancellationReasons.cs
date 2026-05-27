using Core.Common;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Interfaces;

namespace Services.Features.ReferenceData.GetCancellationReasons;

public record GetCancellationReasonsQuery : ICachedQuery<Result<List<CancellationReasonDto>>>
{
    public string CacheKey => "ref:cancellationreasons";
    public string[] Tags => ["reference-data"];
    public TimeSpan Expiration => TimeSpan.FromHours(24);
}

public record CancellationReasonDto(Guid Id, string DisplayName, string DisplayNameAr, string DisplayNameEn);

public class GetCancellationReasonsQueryHandler : IRequestHandler<GetCancellationReasonsQuery, Result<List<CancellationReasonDto>>>
{
    private readonly Services.Abstractions.Persistence.IUnitOfWork _unitOfWork;

    public GetCancellationReasonsQueryHandler(Services.Abstractions.Persistence.IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<List<CancellationReasonDto>>> Handle(GetCancellationReasonsQuery request, CancellationToken cancellationToken)
    {
        var reasons = await _unitOfWork.CancellationReasons.Query()
            .AsNoTracking()
            .Where(r => r.IsActive)
            .OrderBy(r => r.DisplayOrder)
            .ThenBy(r => r.DisplayNameAr)
            .Select(r => new CancellationReasonDto(r.Id, r.DisplayNameAr, r.DisplayNameAr, r.DisplayNameEn))
            .ToListAsync(cancellationToken);

        return Result<List<CancellationReasonDto>>.Success(reasons);
    }
}