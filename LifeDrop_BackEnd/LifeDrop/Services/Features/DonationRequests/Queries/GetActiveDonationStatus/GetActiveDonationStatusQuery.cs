using Core.Common;
using MediatR;

namespace Services.Features.DonationRequests.Queries.GetActiveDonationStatus;

public record GetActiveDonationStatusQuery() : IRequest<Result<ActiveDonationStatusDto>>;
