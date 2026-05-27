using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using Core.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.Donors.VerifyRegistration;

public class VerifyRegistrationCommandHandler : IRequestHandler<VerifyRegistrationCommand, Result<VerifyRegistrationResult>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IJwtTokenGenerator _jwtTokenGenerator;
    private readonly ILogger<VerifyRegistrationCommandHandler> _logger;

    public VerifyRegistrationCommandHandler(IUnitOfWork unitOfWork, IJwtTokenGenerator jwtTokenGenerator, ILogger<VerifyRegistrationCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _jwtTokenGenerator = jwtTokenGenerator;
        _logger = logger;
    }

    public async Task<Result<VerifyRegistrationResult>> Handle(VerifyRegistrationCommand request, CancellationToken cancellationToken)
    {
        // 1. Fetch pending registration
        var pending = await _unitOfWork.PendingRegistrations
            .Query()
            .FirstOrDefaultAsync(p => p.Email == request.Email, cancellationToken);

        if (pending == null)
        {
            _logger.LogWarning("Registration verification failed: no pending registration for {Email}.", request.Email);
            return Result<VerifyRegistrationResult>.Failure(OtpErrors.RegistrationNotFound);
        }

        // 2. Validate OTP
        if (pending.OtpExpiryDate < DateTimeOffset.UtcNow)
        {
            _logger.LogWarning("Registration verification failed: OTP expired for {Email}.", request.Email);
            return Result<VerifyRegistrationResult>.Failure(OtpErrors.Expired);
        }

        if (pending.OtpCode != request.Code)
        {
            _logger.LogWarning("Registration verification failed: invalid code for {Email}.", request.Email);
            return Result<VerifyRegistrationResult>.Failure(OtpErrors.InvalidCode);
        }

        // 3. Create the official User and DonorProfile
        var user = new User
        {
            FirstName = pending.FirstName,
            LastName = pending.LastName,
            Email = pending.Email,
            PhoneNumber = pending.PhoneNumber,
            PasswordHash = pending.PasswordHash,
            DateOfBirth = DateTime.SpecifyKind(pending.DateOfBirth, DateTimeKind.Utc),
            Role = Role.Donor,
            IsActive = true,
            EmailVerified = true,
            DonorProfile = new DonorProfile
            {
                BloodType = pending.BloodType,
                IsMedicallyVerified = false,
                GovernorateId = pending.GovernorateId,
                DistrictId = pending.DistrictId,
                ReliabilityScore = 100
            }
        };

        // 4. Cleanup and Save
        await _unitOfWork.Users.AddAsync(user);
        _unitOfWork.PendingRegistrations.Delete(pending);

        // 5. Generate Login Tokens
        var tokenResponse = _jwtTokenGenerator.CreateTokenPair(user, user.Role.ToString());
        var hashedRefreshToken = _jwtTokenGenerator.HashRefreshToken(tokenResponse.RefreshToken);
        
        user.RefreshTokens.Add(new RefreshToken
        {
            Token = hashedRefreshToken,
            ExpiryDate = tokenResponse.RefreshTokenExpiresAt,
            JwtId = Guid.NewGuid(),
            CreationDate = DateTime.UtcNow,
            IsUsed = false,
            IsRevoked = false
        });

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Donor registered and verified successfully: {UserId} ({Email}).", user.Id, user.Email);

        return Result<VerifyRegistrationResult>.Success(new VerifyRegistrationResult(
            user.Email,
            tokenResponse.AccessToken,
            tokenResponse.RefreshToken));
    }
}
