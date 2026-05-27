namespace Shared.Configuration;

public class DonationSettings
{
    public int CooldownDays { get; set; } = 90;
    public int PointsPerDonation { get; set; } = 50;
    public double ReliabilityPenaltyPerNoShow { get; set; } = 10.0;
    public double ReliabilityPenaltyPerCancellation { get; set; } = 5.0;
    public int AcceptanceTimeoutHours { get; set; } = 2;
}