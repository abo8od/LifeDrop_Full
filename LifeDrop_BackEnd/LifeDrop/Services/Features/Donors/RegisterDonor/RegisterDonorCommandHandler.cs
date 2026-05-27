using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using Services.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;

namespace Services.Features.Donors.RegisterDonor;

public class RegisterDonorCommandHandler : IRequestHandler<RegisterDonorCommand, Result<RegisterDonorResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPasswordHasher _passwordHasher;
    private readonly IOtpService _otpService;
    private readonly ILogger<RegisterDonorCommandHandler> _logger;

    public RegisterDonorCommandHandler(IUnitOfWork unitOfWork, IPasswordHasher passwordHasher, IOtpService otpService, ILogger<RegisterDonorCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _passwordHasher = passwordHasher;
        _otpService = otpService;
        _logger = logger;
    }

    public async Task<Result<RegisterDonorResult>> Handle(RegisterDonorCommand request, CancellationToken cancellationToken)
    {
        var emailLower = request.Email.ToLower();

        // 1. Check if already verified in Users table
        var verifiedUser = await _unitOfWork.Users
            .Query()
            .AnyAsync(u => u.Email == emailLower && u.EmailVerified, cancellationToken);

        if (verifiedUser)
        {
            _logger.LogWarning("Registration failed: email {Email} already exists.", request.Email);
            return Result<RegisterDonorResult>.Failure(UserErrors.DuplicateEmail);
        }

        // 2. Cleanup any previous unverified registrations (either in Users or PendingRegistrations)
        var unverifiedUser = await _unitOfWork.Users
            .Query()
            .FirstOrDefaultAsync(u => u.Email == emailLower && !u.EmailVerified, cancellationToken);

        if (unverifiedUser != null)
        {
            _unitOfWork.Users.Delete(unverifiedUser);
        }

        var existingPending = await _unitOfWork.PendingRegistrations
            .Query()
            .FirstOrDefaultAsync(p => p.Email == emailLower, cancellationToken);

        if (existingPending != null)
        {
            _unitOfWork.PendingRegistrations.Delete(existingPending);
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);
        
        // 3. Validation of location data
        if (request.GovernorateId.HasValue)
        {
            var governorateExists = await _unitOfWork.Governorates
                .Query()
                .AnyAsync(x => x.Id == request.GovernorateId, cancellationToken);

            if (!governorateExists)
                return Result<RegisterDonorResult>.Failure(LocationErrors.GovernorateNotFound);
        }

        if (request.DistrictId.HasValue)
        {
            var districtExists = await _unitOfWork.Districts
                .Query()
                .AnyAsync(x => x.Id == request.DistrictId, cancellationToken);

            if (!districtExists)
                return Result<RegisterDonorResult>.Failure(LocationErrors.DistrictNotFound);
        }

        var bloodType = Enum.Parse<BloodType>(request.BloodType);

        // 4. Create Pending Registration Record (STAGING)
        var otp = _otpService.GenerateOtp();
        var pendingRegistration = new PendingRegistration
        {
            Email = request.Email.ToLower(),
            PasswordHash = _passwordHasher.HashPassword(request.Password),
            FirstName = request.FirstName,
            LastName = request.LastName,
            DateOfBirth = DateTime.SpecifyKind(request.DateOfBirth, DateTimeKind.Utc),
            BloodType = bloodType,
            GovernorateId = request.GovernorateId,
            DistrictId = request.DistrictId,
            PhoneNumber = request.PhoneNumber,
            OtpCode = otp,
            OtpExpiryDate = DateTimeOffset.UtcNow.AddMinutes(15)
        };

        await _unitOfWork.PendingRegistrations.AddAsync(pendingRegistration);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
        
        if (Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development")
        {
            _logger.LogWarning("==================================================");
            _logger.LogWarning(" DEVELOPMENT MODE - OTP FOR {Email} IS: {Otp} ", request.Email, otp);
            _logger.LogWarning("==================================================");
        }

        // 5. Send OTP email — awaited so the caller knows if delivery failed
        try
        {
            await _otpService.SendOtpEmailAsync(request.Email, otp, "Registration", cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send registration email to {Email}.", request.Email);
            return Result<RegisterDonorResult>.Failure(OtpErrors.EmailSendFailed);
        }

        _logger.LogInformation("Pending registration created for {Email}.", request.Email);

        return Result<RegisterDonorResult>.Success(new RegisterDonorResult(Guid.Empty, request.Email));
    }
}
