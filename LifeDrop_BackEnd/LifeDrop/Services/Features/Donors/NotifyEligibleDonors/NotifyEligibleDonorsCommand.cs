using Core.Common;
using MediatR;

namespace Services.Features.Donors.NotifyEligibleDonors;

public record NotifyEligibleDonorsCommand : IRequest<Result<NotifyEligibleDonorsResult>>;

public record NotifyEligibleDonorsResult(int NotifiedCount);
