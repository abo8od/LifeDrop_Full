using Core.Enums;

namespace Services.Features.DonationRequests.Queries.GetDonorFeed;

/// <summary>
/// DTO for donation request items in the donor's feed.
/// </summary>
public class DonationRequestFeedDto
{
    public Guid RequestId { get; set; }
    public string HospitalName { get; set; } = string.Empty;
    public string GovernorateName { get; set; } = string.Empty;
    public string RequiredBloodType { get; set; } = string.Empty;
    public int TargetQuota { get; set; }
    public int RemainingQuota { get; set; }
    public string Urgency { get; set; } = string.Empty;
    public DateTimeOffset ExpiryDate { get; set; }
    public int DistancePriority { get; set; } // 1 = same district, 2 = same governorate
    
    // Hospital coordinates for Maps integration (PRD 3.10)
    public double? HospitalLatitude { get; set; }
    public double? HospitalLongitude { get; set; }
}