using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Features.Hospitals.GetHospitalEmployees;

namespace Services.Features.Admin.Hospitals.GetHospitalEmployees;

public class GetHospitalEmployeesAdminQueryHandler
    : IRequestHandler<GetHospitalEmployeesAdminQuery, Result<List<HospitalEmployeeDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<GetHospitalEmployeesAdminQueryHandler> _logger;

    public GetHospitalEmployeesAdminQueryHandler(IUnitOfWork unitOfWork, ILogger<GetHospitalEmployeesAdminQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<Result<List<HospitalEmployeeDto>>> Handle(
        GetHospitalEmployeesAdminQuery request,
        CancellationToken cancellationToken)
    {
        var hospitalExists = await _unitOfWork.Hospitals
            .Query()
            .AsNoTracking()
            .AnyAsync(h => h.Id == request.HospitalId, cancellationToken);

        if (!hospitalExists)
        {
            _logger.LogWarning("Admin employee list failed: hospital {HospitalId} not found.", request.HospitalId);
            return Result<List<HospitalEmployeeDto>>.Failure(HospitalErrors.NotFound);
        }

        var employees = await _unitOfWork.HospitalEmployeeProfiles
            .Query()
            .AsNoTracking()
            .Where(ep => ep.HospitalId == request.HospitalId)
            .OrderBy(ep => ep.User.FirstName)
            .ThenBy(ep => ep.User.LastName)
            .Select(ep => new HospitalEmployeeDto
            {
                EmployeeProfileId = ep.Id,
                FirstName         = ep.User.FirstName,
                LastName          = ep.User.LastName,
                Email             = ep.User.Email,
                PhoneNumber       = ep.User.PhoneNumber,
                Role              = ep.User.Role.ToString(),
                IsActive          = ep.User.IsActive,
                CreatedOn         = ep.CreatedOn
            })
            .ToListAsync(cancellationToken);

        _logger.LogInformation("Admin fetched {Count} employees for hospital {HospitalId}.", employees.Count, request.HospitalId);

        return Result<List<HospitalEmployeeDto>>.Success(employees);
    }
}
