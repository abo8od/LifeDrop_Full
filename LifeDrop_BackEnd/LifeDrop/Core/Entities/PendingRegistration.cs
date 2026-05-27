using Core.Common;
using Core.Enums;

namespace Core.Entities;

public class PendingRegistration : BaseEntity
{
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public DateTime DateOfBirth { get; set; }
    public BloodType BloodType { get; set; }
    public Guid? GovernorateId { get; set; }
    public Guid? DistrictId { get; set; }
    public string PhoneNumber { get; set; } = string.Empty;
    
    public string OtpCode { get; set; } = string.Empty;
    public DateTimeOffset OtpExpiryDate { get; set; }
}
