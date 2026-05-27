using Core.Common;
using Core.Enums;

namespace Core.Entities;

public class User : BaseEntity
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public Role Role { get; set; }
    public bool IsActive { get; set; } = true;
    public bool EmailVerified { get; set; } = false;
    public DateTime DateOfBirth { get; set; }

    // Navigation properties
    public DonorProfile? DonorProfile { get; set; }
    public HospitalEmployeeProfile? HospitalEmployeeProfile { get; set; }
    public ICollection<RefreshToken> RefreshTokens { get; set; } = new HashSet<RefreshToken>();

    // Business Actions (State Changes)
    public Result Activate()
    {
        if (IsActive) return Result.Success();
        IsActive = true;
        return Result.Success();
    }

    public Result Deactivate()
    {
        if (!IsActive) return Result.Success();
        IsActive = false;
        return Result.Success();
    }
}
