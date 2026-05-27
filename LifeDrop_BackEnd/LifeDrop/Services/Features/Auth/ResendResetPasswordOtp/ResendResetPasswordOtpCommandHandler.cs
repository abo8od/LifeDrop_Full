using Core.Common;
using Core.Common.Errors;
using Core.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Interfaces;

namespace Services.Features.Auth.ResendResetPasswordOtp;

public record ResendResetPasswordOtpCommand(string Email) : IRequest<Result>;

public class ResendResetPasswordOtpCommandHandler : IRequestHandler<ResendResetPasswordOtpCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IOtpService _otpService;
    private readonly ILogger<ResendResetPasswordOtpCommandHandler> _logger;

    public ResendResetPasswordOtpCommandHandler(IUnitOfWork unitOfWork, IOtpService otpService, ILogger<ResendResetPasswordOtpCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _otpService = otpService;
        _logger = logger;
    }

    public async Task<Result> Handle(ResendResetPasswordOtpCommand request, CancellationToken cancellationToken)
    {
        var emailLower = request.Email.ToLower();
        var user = await _unitOfWork.Users.Query()
            .FirstOrDefaultAsync(u => u.Email == emailLower, cancellationToken);

        if (user == null)
        {
            return Result.Failure(UserErrors.EmailNotFound);
        }

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

        if (Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development")
        {
            _logger.LogWarning("==================================================");
            _logger.LogWarning(" DEVELOPMENT MODE - RESEND OTP FOR {Email} IS: {Otp} ", user.Email, otpCodeString);
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
                _logger.LogError(ex, "Failed to resend reset password email to {Email}", user.Email);
            }
        });

        return Result.Success();
    }
}
