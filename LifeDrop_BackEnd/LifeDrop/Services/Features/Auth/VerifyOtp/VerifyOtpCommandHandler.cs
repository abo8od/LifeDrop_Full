using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Services.Abstractions.Persistence;
using Microsoft.Extensions.Logging;

namespace Services.Features.Auth.VerifyOtp;

public class VerifyOtpCommandHandler : IRequestHandler<VerifyOtpCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<VerifyOtpCommandHandler> _logger;

    public VerifyOtpCommandHandler(IUnitOfWork unitOfWork, ILogger<VerifyOtpCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<Result> Handle(VerifyOtpCommand request, CancellationToken cancellationToken)
    {
        var emailLower = request.Email.ToLower();

        var otp = await _unitOfWork.OtpCodes.Query()
            .Where(o => o.User.Email == emailLower && o.Code == request.Code && !o.IsUsed)
            .OrderByDescending(o => o.ExpiryDate)
            .FirstOrDefaultAsync(cancellationToken);

        if (otp == null)
        {
            _logger.LogWarning("OTP verification failed: invalid code for {Email}.", request.Email);
            return Result.Failure(OtpErrors.InvalidCode);
        }

        if (otp.ExpiryDate < DateTime.UtcNow)
        {
            _logger.LogWarning("OTP verification failed: code expired for {Email}.", request.Email);
            return Result.Failure(OtpErrors.Expired);
        }

        otp.MarkAsUsed();
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("OTP verified successfully for {Email}.", request.Email);

        return Result.Success();
    }
}
