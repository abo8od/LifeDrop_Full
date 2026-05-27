using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using Services.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Microsoft.Extensions.Logging;

namespace Services.Features.Admin.Hospitals.CreateHospitalEmployee;

public class CreateHospitalEmployeeCommandHandler : IRequestHandler<CreateHospitalEmployeeCommand, Result<CreateHospitalEmployeeResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ILogger<CreateHospitalEmployeeCommandHandler> _logger;

    public CreateHospitalEmployeeCommandHandler(IUnitOfWork unitOfWork, IPasswordHasher passwordHasher, ILogger<CreateHospitalEmployeeCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _passwordHasher = passwordHasher;
        _logger = logger;
    }

    public async Task<Result<CreateHospitalEmployeeResult>> Handle(CreateHospitalEmployeeCommand request, CancellationToken cancellationToken)
    {
        var hospital = await _unitOfWork.Hospitals
            .Query()
            .FirstOrDefaultAsync(h => h.Id == request.HospitalId, cancellationToken);

        if (hospital == null)
        {
            _logger.LogWarning("Hospital employee creation failed: hospital {HospitalId} not found.", request.HospitalId);
            return Result<CreateHospitalEmployeeResult>.Failure(HospitalErrors.NotFound);
        }

        var existingUser = await _unitOfWork.Users
            .Query()
            .FirstOrDefaultAsync(u => u.Email == request.Email.ToLower(), cancellationToken);

        if (existingUser != null)
        {
            _logger.LogWarning("Hospital employee creation failed: email {Email} already exists.", request.Email);
            return Result<CreateHospitalEmployeeResult>.Failure(HospitalErrors.DuplicateEmail);
        }

        var user = new User
        {
            FirstName = request.FirstName,
            LastName = request.LastName,
            Email = request.Email.ToLower(),
            PasswordHash = _passwordHasher.HashPassword(request.Password),
            Role = Role.HospitalEmployee,
            IsActive = true,
            EmailVerified = true,
            HospitalEmployeeProfile = new HospitalEmployeeProfile
            {
                HospitalId = request.HospitalId
            }
        };

        await _unitOfWork.Users.AddAsync(user);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Hospital employee {UserId} ({Email}) created for hospital {HospitalId}.", user.Id, user.Email, request.HospitalId);

        return Result<CreateHospitalEmployeeResult>.Success(new CreateHospitalEmployeeResult(user.Id, user.Email, request.HospitalId));
    }
}
