using Core.Common;
using Services.Interfaces;
using System.Security.Cryptography;

namespace Infrastructure.Services;

public class OtpService : IOtpService
{
    private readonly IEmailService _emailService;

    public OtpService(IEmailService emailService)
    {
        _emailService = emailService;
    }

    public string GenerateOtp()
    {
        return RandomNumberGenerator.GetInt32(100000, 999999).ToString();
    }

    public async Task SendOtpEmailAsync(string email, string otpCode, string purpose, CancellationToken cancellationToken)
    {
        string title = purpose switch
        {
            "ResetPassword" => "إعادة تعيين كلمة المرور",
            "Registration" => "تفعيل الحساب",
            _ => "رمز التحقق"
        };

        string message = purpose switch
        {
            "ResetPassword" => "لقد تلقينا طلباً لإعادة تعيين كلمة المرور الخاصة بحسابك. يرجى استخدام رمز التحقق التالي لإكمال العملية:",
            "Registration" => "شكراً لانضمامك إلى LifeDrop. يرجى استخدام رمز التحقق التالي لتفعيل حسابك:",
            _ => "يرجى استخدام رمز التحقق التالي لإكمال العملية:"
        };

        string subject = purpose switch
        {
            "ResetPassword" => "LifeDrop - Password Reset Code",
            "Registration" => "LifeDrop - Verify your account",
            _ => "LifeDrop - Verification Code"
        };

        var body = GetHtmlTemplate(title, message, otpCode);

        await _emailService.SendEmailAsync(email, subject, body, cancellationToken);
    }

    private string GetHtmlTemplate(string title, string message, string otpCode)
    {
        return $$"""
        <!DOCTYPE html>
        <html lang="ar" dir="rtl">
        <head>
            <meta charset="UTF-8">
            <style>
                body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; margin: 0; padding: 0; }
                .container { max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
                .header { background-color: #e53935; color: #ffffff; padding: 30px; text-align: center; }
                .header h1 { margin: 0; font-size: 26px; }
                .content { padding: 40px 30px; text-align: center; color: #333333; }
                .content h2 { margin-top: 0; color: #222222; }
                .content p { font-size: 16px; line-height: 1.6; color: #555555; margin-bottom: 25px; }
                .otp-box { background-color: #ffebee; border: 2px dashed #e53935; border-radius: 8px; padding: 20px; font-size: 36px; font-weight: bold; color: #e53935; letter-spacing: 8px; margin: 0 auto 25px auto; width: fit-content; }
                .footer { background-color: #f9fafb; padding: 20px; text-align: center; font-size: 13px; color: #999999; border-top: 1px solid #eeeeee; }
                .warning { font-size: 14px; color: #777777; }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>LifeDrop</h1>
                </div>
                <div class="content">
                    <h2>{{title}}</h2>
                    <p>مرحباً،<br>{{message}}</p>
                    <div class="otp-box">{{otpCode}}</div>
                    <p class="warning">هذا الرمز صالح لمدة <strong>15 دقيقة</strong> فقط. إذا لم تطلب هذا الرمز، يرجى تجاهل هذه الرسالة.</p>
                </div>
                <div class="footer">
                    &copy; {{DateTime.UtcNow.Year}} تطبيق LifeDrop. جميع الحقوق محفوظة.
                </div>
            </div>
        </body>
        </html>
        """;
    }
}
