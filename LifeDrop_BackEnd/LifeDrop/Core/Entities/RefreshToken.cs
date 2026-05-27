using Core.Common;

namespace Core.Entities;

public class RefreshToken : BaseEntity
{
    public string Token { get; set; } = string.Empty;
    public Guid UserId { get; set; }
    public Guid JwtId { get; set; }
    public DateTime CreationDate { get; set; }
    public DateTime ExpiryDate { get; set; }
    public bool IsUsed { get; set; }
    public bool IsRevoked { get; set; }

    public User User { get; set; } = null!;

    // Business Actions (State Changes)
    public Result MarkAsUsed()
    {
        if (IsUsed) return Result.Success();
        IsUsed = true;
        return Result.Success();
    }

    public Result Revoke()
    {
        if (IsRevoked) return Result.Success();
        IsRevoked = true;
        return Result.Success();
    }
}
