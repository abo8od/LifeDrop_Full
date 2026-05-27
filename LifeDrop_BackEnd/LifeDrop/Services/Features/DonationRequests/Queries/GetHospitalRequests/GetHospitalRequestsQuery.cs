using Core.Enums;
using MediatR;
using Shared.Responses;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Text.Json.Serialization;
using Core.Common;

namespace Services.Features.DonationRequests.Queries.GetHospitalRequests;

/// <summary>
/// Query to get all donation requests for the current hospital.
/// Filters by HospitalId from JWT token and optionally by status.
/// </summary>
public record GetHospitalRequestsQuery : IRequest<Result<PagedResponse<HospitalRequestSummaryDto>>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public RequestStatus? Status { get; set; }
    public string? SearchTerm { get; set; }

    [JsonIgnore]
    [BindNever]
    public Guid HospitalId { get; set; }
}