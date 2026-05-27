using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Shared.Responses;

namespace Services.Features.Hospitals.GetHospitalEmployees;

public class GetHospitalEmployeesQueryHandler : IRequestHandler<GetHospitalEmployeesQuery, Result<PagedResponse<HospitalEmployeeDto>>>
{
    private readonly IUnitOfWork _unitOfWork;

    public GetHospitalEmployeesQueryHandler(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<PagedResponse<HospitalEmployeeDto>>> Handle(GetHospitalEmployeesQuery request, CancellationToken cancellationToken)
    {
        var hospitalExists = await _unitOfWork.Hospitals
            .Query()
            .AsNoTracking()
            .AnyAsync(h => h.Id == request.HospitalId, cancellationToken);

        if (!hospitalExists)
            return Result<PagedResponse<HospitalEmployeeDto>>.Failure(HospitalErrors.NotFound);

        var query = _unitOfWork.HospitalEmployeeProfiles
            .Query()
            .AsNoTracking()
            .Where(ep => ep.HospitalId == request.HospitalId);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            var search = request.SearchTerm.Trim().ToLower();
            query = query.Where(ep =>
                ep.User.FirstName.ToLower().Contains(search) ||
                ep.User.LastName.ToLower().Contains(search) ||
                ep.User.Email.ToLower().Contains(search));
        }

        var totalCount = await query.CountAsync(cancellationToken);

        var pageNumber = request.PageNumber ?? 1;
        var pageSize = request.PageSize ?? 10;

        var employees = await query
            .OrderBy(ep => ep.User.FirstName)
            .ThenBy(ep => ep.User.LastName)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .Select(ep => new HospitalEmployeeDto
            {
                EmployeeProfileId = ep.Id,
                FirstName = ep.User.FirstName,
                LastName = ep.User.LastName,
                Email = ep.User.Email,
                PhoneNumber = ep.User.PhoneNumber,
                Role = ep.User.Role.ToString(),
                IsActive = ep.User.IsActive,
                CreatedOn = ep.CreatedOn
            })
            .ToListAsync(cancellationToken);

        var pagedResponse = new PagedResponse<HospitalEmployeeDto>(employees, totalCount, pageNumber, pageSize);
        return Result<PagedResponse<HospitalEmployeeDto>>.Success(pagedResponse);
    }
}
