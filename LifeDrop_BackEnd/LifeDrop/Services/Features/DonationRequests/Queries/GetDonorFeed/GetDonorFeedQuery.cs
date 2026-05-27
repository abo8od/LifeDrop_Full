using Core.Enums;
using MediatR;
using Shared.Responses;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Text.Json.Serialization;
using Core.Common;

namespace Services.Features.DonationRequests.Queries.GetDonorFeed;

/// <summary>
/// Query to get the donor's personalized feed of active donation requests.
/// Filters by location (governorate/district) and blood type compatibility.
/// </summary>
public record GetDonorFeedQuery : IRequest<Result<PagedResponse<DonationRequestFeedDto>>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? SearchTerm { get; set; }
    public UrgencyLevel? Urgency { get; set; }

    [JsonIgnore]
    [BindNever]
    public Guid UserId { get; set; }
}