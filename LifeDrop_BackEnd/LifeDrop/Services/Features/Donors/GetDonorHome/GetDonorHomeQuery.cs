using Core.Common;
using MediatR;

namespace Services.Features.Donors.GetDonorHome;

public record GetDonorHomeQuery : IRequest<Result<DonorHomeDto>>
{
    public Guid UserId { get; init; }
}
