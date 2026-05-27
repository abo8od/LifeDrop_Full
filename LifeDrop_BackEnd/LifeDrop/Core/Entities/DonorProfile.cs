using Core.Enums;

namespace Core.Entities;

public class DonorProfile : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public BloodType? BloodType { get; set; }
    public bool IsMedicallyVerified { get; set; }
    
    public Guid? GovernorateId { get; set; }
    public Governorate? Governorate { get; set; }

    public Guid? DistrictId { get; set; }
    public District? District { get; set; }

    public DateTimeOffset? LastDonationDate { get; set; }
    public DateTimeOffset? EligibilityNotificationSentFor { get; set; }
    public double ReliabilityScore { get; set; }
    public int GamificationPoints { get; set; }

    public bool IsAvailable { get; set; } = true;

    // Notification Settings
    public bool ReceiveCriticalNotifications { get; set; } = true;
    public bool ReceiveUrgentNotifications { get; set; } = true;
    public bool ReceiveNormalNotifications { get; set; } = true;
    
    public ICollection<DonationAcceptance> DonationAcceptances { get; set; } = new List<DonationAcceptance>();
}