using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Text.Json.Serialization;
using Core.Common;

namespace Services.Features.DonationRequests.Queries.GetDonorDonationRequestDetails;

public class GetDonorDonationRequestDetailsQuery : IRequest<Result<DonorDonationRequestDetailsDto>>
{
    public Guid RequestId { get; init; }

    [JsonIgnore]
    [BindNever]
    public Guid UserId { get; init; }

    public GetDonorDonationRequestDetailsQuery(Guid requestId, Guid userId)
    {
        RequestId = requestId;
        UserId = userId;
    }
}

public class DonorDonationRequestDetailsDto
{
    public Guid RequestId { get; set; }
    public string HospitalName { get; set; } = string.Empty;
    public string HospitalAddress { get; set; } = string.Empty;
    public double HospitalLatitude { get; set; }
    public double HospitalLongitude { get; set; }
    public string HospitalPhoneNumber { get; set; } = string.Empty;
    public string RequiredBloodType { get; set; } = string.Empty;
    public string Urgency { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public DateTimeOffset ExpiryDate { get; set; }
    public bool IsAcceptedByCurrentUser { get; set; }
    public string? CurrentUserAcceptanceStatus { get; set; }
    public DateTime? AcceptedAt { get; set; }
}
