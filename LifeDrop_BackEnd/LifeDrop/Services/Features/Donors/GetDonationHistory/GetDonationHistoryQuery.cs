using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Shared.Responses;
using System.Text.Json.Serialization;

namespace Services.Features.Donors.GetDonationHistory;

public record GetDonationHistoryQuery : IRequest<Result<PagedResponse<DonationHistoryDto>>>
{
    [JsonIgnore]
    [BindNever]
    public Guid? UserId { get; set; }
    public int? PageNumber { get; init; } = 1;
    public int? PageSize { get; init; } = 10;
}
