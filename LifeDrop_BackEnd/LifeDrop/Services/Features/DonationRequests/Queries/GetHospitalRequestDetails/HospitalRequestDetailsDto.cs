using Core.Enums;

namespace Services.Features.DonationRequests.Queries.GetHospitalRequestDetails;

/// <summary>
/// DTO for accepted donor information in request details.
/// </summary>
public class AcceptedDonorDto
{
    public Guid AcceptanceId { get; set; }
    public string DonorName { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public string BloodType { get; set; } = string.Empty;
    public bool IsMedicallyVerified { get; set; }
    public string Status { get; set; } = string.Empty;
    public DateTimeOffset AcceptedAt { get; set; }
}

/// <summary>
/// DTO for detailed donation request view in hospital dashboard.
/// Includes acceptances with donor contact information.
/// </summary>
public class HospitalRequestDetailsDto
{
    public Guid RequestId { get; set; }
    public string HospitalName { get; set; } = string.Empty;
    public string BloodType { get; set; } = string.Empty;
    public int TargetQuota { get; set; }
    public int CurrentActiveAcceptances { get; set; }
    public int CurrentFulfilledAcceptances { get; set; }
    public string Urgency { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public DateTimeOffset CreatedOn { get; set; }
    public DateTimeOffset ExpiryDate { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string HospitalAddress { get; set; } = string.Empty;
    
    public List<string> TargetDistricts { get; set; } = new();
    public List<AcceptedDonorDto> Acceptances { get; set; } = new();
}