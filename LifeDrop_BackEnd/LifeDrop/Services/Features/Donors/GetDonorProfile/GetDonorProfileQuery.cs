using Core.Common;
using MediatR;
using Services.Interfaces;
using Shared.Configuration;

namespace Services.Features.Donors.GetDonorProfile;

public record GetDonorProfileQuery(Guid UserId) : ICachedQuery<Result<DonorProfileDto>>
{
    public string CacheKey => $"profile:donor:{UserId}";
    public string[] Tags => [$"donor_{UserId}"];
    public TimeSpan Expiration => TimeSpan.FromHours(1);
}

public class DonorProfileDto
{
    public Guid UserId { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? Email { get; set; }
    public string? PhoneNumber { get; set; }
    public string? BloodType { get; set; }
    public bool IsMedicallyVerified { get; set; }
    public bool IsAvailable { get; set; }
    public string? GovernorateName { get; set; }
    public string? DistrictName { get; set; }
    public double ReliabilityScore { get; set; }
    public int GamificationPoints { get; set; }
    public DateTimeOffset? LastDonationDate { get; set; }
    public bool IsEligibleToDonate { get; set; }
    public DateTimeOffset? NextEligibleDate { get; set; }
    
    public int TotalDonations { get; set; }
    public bool? ReceiveCriticalNotifications { get; set; }
    public bool? ReceiveUrgentNotifications { get; set; }
    public bool? ReceiveNormalNotifications { get; set; }
}