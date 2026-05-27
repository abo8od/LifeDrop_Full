using Core.Enums;

namespace Services.Features.DonationRequests.Queries.GetActiveDonationStatus;

public class ActiveDonationStatusDto
{
    public Guid AcceptanceId { get; set; }
    public Guid RequestId { get; set; }
    
    // Hospital Info
    public string HospitalName { get; set; } = string.Empty;
    public string HospitalAddress { get; set; } = string.Empty;
    public string HospitalPhoneNumber { get; set; } = string.Empty;
    public double HospitalLatitude { get; set; }
    public double HospitalLongitude { get; set; }
    
    // Request Info
    public string RequiredBloodType { get; set; } = string.Empty;
    public string Urgency { get; set; } = string.Empty;
    public int UnitsRequested { get; set; }
    public string Status { get; set; } = string.Empty;
    
    // Timing
    public DateTime AcceptedAt { get; set; }
    public int RemainingMinutes { get; set; }
}
