using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Interfaces;

namespace Services.Features.Auth.ForgotPassword;

public class ForgotPasswordCommandHandler : IRequestHandler<ForgotPasswordCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IOtpService _otpService;
    private readonly ILogger<ForgotPasswordCommandHandler> _logger;

    public ForgotPasswordCommandHandler(IUnitOfWork unitOfWork, IOtpService otpService, ILogger<ForgotPasswordCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _otpService = otpService;
        _logger = logger;
    }

    public async Task<Result> Handle(ForgotPasswordCommand request, CancellationToken cancellationToken)
    {
        var emailLower = request.Email.ToLower();
        var user = await _unitOfWork.Users.Query()
            .FirstOrDefaultAsync(u => u.Email == emailLower, cancellationToken);

        if (user == null)
        {
            _logger.LogWarning("Password reset failed: user not found for {Email}.", request.Email);
            return Result.Failure(UserErrors.EmailNotFound);
        }

        // Generate 6-digit OTP
        var otpCodeString = _otpService.GenerateOtp();

        // Invalidate previous active OTPs for this user
        var existingOtps = await _unitOfWork.OtpCodes.Query()
            .Where(o => o.UserId == user.Id && !o.IsUsed && o.ExpiryDate > DateTime.UtcNow)
            .ToListAsync(cancellationToken);

        foreach (var existingOtp in existingOtps)
        {
            existingOtp.IsUsed = true;
        }

        var newOtp = new OtpCode
        {
            Code = otpCodeString,
            UserId = user.Id,
            ExpiryDate = DateTime.UtcNow.AddMinutes(15),
            IsUsed = false
        };

        await _unitOfWork.OtpCodes.AddAsync(newOtp);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
        
        // للاستخدام في بيئة التطوير: طباعة الكود في الـ Terminal
        if (Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development")
        {
            _logger.LogWarning("==================================================");
            _logger.LogWarning(" DEVELOPMENT MODE - OTP FOR {Email} IS: {Otp} ", user.Email, otpCodeString);
            _logger.LogWarning("==================================================");
        }

        _ = Task.Run(async () =>
        {
            try
            {
                await _otpService.SendOtpEmailAsync(user.Email, otpCodeString, "ResetPassword", CancellationToken.None);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send reset password email to {Email}", user.Email);
            }
        });

        _logger.LogInformation("Password reset OTP sent for {Email}.", user.Email);

        return Result.Success();
    }
}
