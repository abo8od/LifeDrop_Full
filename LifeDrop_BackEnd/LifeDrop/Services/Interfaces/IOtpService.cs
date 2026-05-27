using Core.Common;

namespace Services.Interfaces;

public interface IOtpService
{
    string GenerateOtp();
    Task SendOtpEmailAsync(string email, string otpCode, string purpose, CancellationToken cancellationToken);
}
