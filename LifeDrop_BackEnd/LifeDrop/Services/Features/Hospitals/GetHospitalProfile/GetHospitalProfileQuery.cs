using Core.Common;
using MediatR;

namespace Services.Features.Hospitals.GetHospitalProfile;

public record GetHospitalProfileQuery(Guid HospitalId) : IRequest<Result<HospitalProfileDto>>;

public class HospitalProfileDto
{
    public Guid HospitalId { get; set; }
    public string Name { get; set; } = string.Empty;
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public bool IsVerified { get; set; }
    public string Address { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public int TotalRequests { get; set; }
    public int ActiveRequests { get; set; }
    public int FulfilledRequests { get; set; }
    public int CancelledRequests { get; set; }
    public int TotalEmployees { get; set; }
    public int TotalDonorsServed { get; set; }
    
    // Additional Analytics for Dashboard
    public int TotalNoShows { get; set; }
    public double FulfillmentRate { get; set; }
    public double NoShowRate { get; set; }
}