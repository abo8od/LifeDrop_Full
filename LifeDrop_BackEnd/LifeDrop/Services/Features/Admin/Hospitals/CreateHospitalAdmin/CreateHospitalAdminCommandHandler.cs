using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using Services.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Microsoft.Extensions.Logging;

namespace Services.Features.Admin.Hospitals.CreateHospitalAdmin;

public class CreateHospitalAdminCommandHandler : IRequestHandler<CreateHospitalAdminCommand, Result<CreateHospitalAdminResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ILogger<CreateHospitalAdminCommandHandler> _logger;

    public CreateHospitalAdminCommandHandler(IUnitOfWork unitOfWork, IPasswordHasher passwordHasher, ILogger<CreateHospitalAdminCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _passwordHasher = passwordHasher;
        _logger = logger;
    }

    public async Task<Result<CreateHospitalAdminResult>> Handle(CreateHospitalAdminCommand request, CancellationToken cancellationToken)
    {
        var hospital = await _unitOfWork.Hospitals
            .Query()
            .FirstOrDefaultAsync(h => h.Id == request.HospitalId, cancellationToken);

        if (hospital == null)
        {
            _logger.LogWarning("Hospital admin creation failed: hospital {HospitalId} not found.", request.HospitalId);
            return Result<CreateHospitalAdminResult>.Failure(HospitalErrors.NotFound);
        }

        var existingUser = await _unitOfWork.Users
            .Query()
            .FirstOrDefaultAsync(u => u.Email == request.Email.ToLower(), cancellationToken);

        if (existingUser != null)
        {
            _logger.LogWarning("Hospital admin creation failed: email {Email} already exists.", request.Email);
            return Result<CreateHospitalAdminResult>.Failure(HospitalErrors.DuplicateEmail);
        }

        var user = new User
        {
            FirstName = request.FirstName,
            LastName = request.LastName,
            Email = request.Email.ToLower(),
            PasswordHash = _passwordHasher.HashPassword(request.Password),
            Role = Role.HospitalAdmin,
            IsActive = true,
            EmailVerified = true,
            HospitalEmployeeProfile = new HospitalEmployeeProfile
            {
                HospitalId = request.HospitalId
            }
        };

        await _unitOfWork.Users.AddAsync(user);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Hospital admin {UserId} ({Email}) created for hospital {HospitalId}.", user.Id, user.Email, request.HospitalId);

        return Result<CreateHospitalAdminResult>.Success(new CreateHospitalAdminResult(user.Id, user.Email, request.HospitalId));
    }
}
