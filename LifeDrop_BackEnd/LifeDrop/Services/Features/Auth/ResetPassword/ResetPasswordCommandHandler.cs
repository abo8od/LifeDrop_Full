using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Services.Interfaces;
using Microsoft.Extensions.Logging;

namespace Services.Features.Auth.ResetPassword;

public class ResetPasswordCommandHandler : IRequestHandler<ResetPasswordCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ILogger<ResetPasswordCommandHandler> _logger;

    public ResetPasswordCommandHandler(IUnitOfWork unitOfWork, IPasswordHasher passwordHasher, ILogger<ResetPasswordCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _passwordHasher = passwordHasher;
        _logger = logger;
    }

    public async Task<Result> Handle(ResetPasswordCommand request, CancellationToken cancellationToken)
    {
        var emailLower = request.Email.ToLower();
        var user = await _unitOfWork.Users.Query()
            .FirstOrDefaultAsync(u => u.Email == emailLower, cancellationToken);

        if (user == null)
        {
            _logger.LogWarning("Password reset failed: user not found for {Email}.", request.Email);
            return Result.Failure(UserErrors.EmailNotFound);
        }

        var otp = await _unitOfWork.OtpCodes.Query()
            .Where(o => o.UserId == user.Id && o.Code == request.Code && !o.IsUsed)
            .OrderByDescending(o => o.ExpiryDate)
            .FirstOrDefaultAsync(cancellationToken);

        if (otp == null)
        {
            _logger.LogWarning("Password reset failed: invalid OTP code for {Email}.", request.Email);
            return Result.Failure(OtpErrors.InvalidCode);
        }

        if (otp.ExpiryDate < DateTime.UtcNow)
        {
            _logger.LogWarning("Password reset failed: OTP expired for {Email}.", request.Email);
            return Result.Failure(OtpErrors.Expired);
        }

        if (_passwordHasher.VerifyPassword(request.NewPassword, user.PasswordHash))
        {
            _logger.LogWarning("Password reset failed: new password is same as old for {Email}.", request.Email);
            return Result.Failure(AuthenticationErrors.SamePasswordAsOld);
        }

        // Mark OTP as used
        otp.MarkAsUsed();

        // Update password
        user.PasswordHash = _passwordHasher.HashPassword(request.NewPassword);

        // Revoke all refresh tokens
        var refreshTokens = await _unitOfWork.RefreshTokens.Query()
            .Where(rt => rt.UserId == user.Id && !rt.IsRevoked)
            .ToListAsync(cancellationToken);

        foreach (var rt in refreshTokens)
        {
            rt.Revoke();
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Password reset successfully for user {UserId}. {TokenCount} refresh tokens revoked.", 
            user.Id, refreshTokens.Count);

        return Result.Success();
    }
}
