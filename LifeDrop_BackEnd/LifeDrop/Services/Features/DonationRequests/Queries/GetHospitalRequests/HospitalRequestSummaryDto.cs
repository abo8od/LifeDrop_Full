using Core.Enums;

namespace Services.Features.DonationRequests.Queries.GetHospitalRequests;

/// <summary>
/// DTO for donation request summary in hospital dashboard.
/// </summary>
public class HospitalRequestSummaryDto
{
    public Guid RequestId { get; set; }
    public string BloodType { get; set; } = string.Empty;
    public string Urgency { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public int TargetQuota { get; set; }
    public int CurrentActiveAcceptances { get; set; }
    public int CurrentFulfilledAcceptances { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset ExpiryDate { get; set; }
    public int RemainingSlots => TargetQuota - CurrentActiveAcceptances;
    public double FulfillmentPercentage => TargetQuota > 0 ? (double)CurrentFulfilledAcceptances / TargetQuota * 100 : 0;
}