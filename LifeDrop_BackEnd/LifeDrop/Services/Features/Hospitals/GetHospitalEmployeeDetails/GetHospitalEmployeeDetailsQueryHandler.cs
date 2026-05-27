using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;

namespace Services.Features.Hospitals.GetHospitalEmployeeDetails;

public class GetHospitalEmployeeDetailsQueryHandler : IRequestHandler<GetHospitalEmployeeDetailsQuery, Result<HospitalEmployeeDetailsDto>>
{
    private readonly IUnitOfWork _unitOfWork;

    public GetHospitalEmployeeDetailsQueryHandler(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<HospitalEmployeeDetailsDto>> Handle(GetHospitalEmployeeDetailsQuery request, CancellationToken cancellationToken)
    {
        var employee = await _unitOfWork.HospitalEmployeeProfiles
            .Query()
            .AsNoTracking()
            .Where(ep => ep.Id == request.EmployeeProfileId && ep.HospitalId == request.HospitalId)
            .Select(ep => new HospitalEmployeeDetailsDto
            {
                EmployeeProfileId = ep.Id,
                HospitalId = ep.HospitalId,
                FirstName = ep.User.FirstName,
                LastName = ep.User.LastName,
                Email = ep.User.Email,
                PhoneNumber = ep.User.PhoneNumber,
                Role = ep.User.Role.ToString(),
                IsActive = ep.User.IsActive,
                EmailVerified = ep.User.EmailVerified,
                DateOfBirth = ep.User.DateOfBirth,
                CreatedOn = ep.CreatedOn,
                ModifiedOn = ep.ModifiedOn
            })
            .FirstOrDefaultAsync(cancellationToken);

        if (employee == null)
            return Result<HospitalEmployeeDetailsDto>.Failure(HospitalErrors.EmployeeNotFound);

        return Result<HospitalEmployeeDetailsDto>.Success(employee);
    }
}
