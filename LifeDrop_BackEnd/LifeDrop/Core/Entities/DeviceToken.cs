using Core.Enums;

namespace Core.Entities;

public class DeviceToken : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    /// <summary>FCM registration token (Android) or APNs device token relayed through FCM (iOS).</summary>
    public string Token { get; set; } = string.Empty;

    public DevicePlatform Platform { get; set; }
}
