using Core.Common;
using Core.Enums;
using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Shared.Responses;
using System.Text.Json.Serialization;

namespace Services.Features.DonationRequests.Queries.GetDonorActiveRequests;

public record GetDonorActiveRequestsQuery : IRequest<Result<PagedResponse<DonorActiveRequestDto>>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public UrgencyLevel? Urgency { get; set; }
    public string? SearchTerm { get; set; }

    [JsonIgnore]
    [BindNever]
    public Guid UserId { get; set; }
}
