using Core.Common;

namespace Core.Entities;

public class OtpCode : BaseEntity
{
    public string Code { get; set; } = string.Empty;
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public DateTime ExpiryDate { get; set; }
    public bool IsUsed { get; set; }

    public Result MarkAsUsed()
    {
        if (IsUsed) return Result.Success();
        IsUsed = true;
        return Result.Success();
    }
}
