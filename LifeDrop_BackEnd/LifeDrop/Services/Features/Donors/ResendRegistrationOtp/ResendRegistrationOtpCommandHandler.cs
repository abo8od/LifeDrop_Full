using Core.Common;
using Core.Common.Errors;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Services.Abstractions.Persistence;
using Services.Interfaces;

namespace Services.Features.Donors.ResendRegistrationOtp;

public record ResendRegistrationOtpCommand(string Email) : IRequest<Result>;

public class ResendRegistrationOtpCommandHandler : IRequestHandler<ResendRegistrationOtpCommand, Result>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IOtpService _otpService;
    private readonly ILogger<ResendRegistrationOtpCommandHandler> _logger;

    public ResendRegistrationOtpCommandHandler(IUnitOfWork unitOfWork, IOtpService otpService, ILogger<ResendRegistrationOtpCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _otpService = otpService;
        _logger = logger;
    }

    public async Task<Result> Handle(ResendRegistrationOtpCommand request, CancellationToken cancellationToken)
    {
        var pending = await _unitOfWork.PendingRegistrations
            .Query()
            .FirstOrDefaultAsync(p => p.Email == request.Email, cancellationToken);

        if (pending == null)
        {
            return Result.Failure(OtpErrors.RegistrationNotFound);
        }

        // Generate new OTP
        var otp = _otpService.GenerateOtp();
        
        // Update pending registration
        pending.OtpCode = otp;
        pending.OtpExpiryDate = DateTimeOffset.UtcNow.AddMinutes(15);

        await _unitOfWork.SaveChangesAsync(cancellationToken);
        
        if (Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development")
        {
            _logger.LogWarning("==================================================");
            _logger.LogWarning(" DEVELOPMENT MODE - RESEND OTP FOR {Email} IS: {Otp} ", request.Email, otp);
            _logger.LogWarning("==================================================");
        }

        _ = Task.Run(async () =>
        {
            try
            {
                await _otpService.SendOtpEmailAsync(request.Email, otp, "Registration", CancellationToken.None);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to resend registration email to {Email}", request.Email);
            }
        });

        return Result.Success();
    }
}
