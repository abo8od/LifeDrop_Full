using Core.Common;
using MediatR;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Shared.Requests;
using Shared.Responses;
using System.Text.Json.Serialization;

namespace Services.Features.Hospitals.GetDonorCommunication;

public class GetDonorCommunicationQuery : PagedRequest, IRequest<Result<PagedResponse<DonorInteractionDto>>>
{
    [JsonIgnore]
    [BindNever]
    public Guid? HospitalId { get; set; }
}
