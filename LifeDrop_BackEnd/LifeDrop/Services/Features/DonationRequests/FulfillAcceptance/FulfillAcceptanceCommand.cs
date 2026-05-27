using Core.Common;
using MediatR;

namespace Services.Features.DonationRequests.FulfillAcceptance;

/// <summary>
/// Command to mark a donor's acceptance as fulfilled (donation completed).
/// Called by Hospital Employee when donor arrives and completes donation.
/// </summary>
public record FulfillAcceptanceCommand(
    Guid AcceptanceId
) : IRequest<Result<FulfillAcceptanceResult>>;

/// <summary>
/// Result of fulfilling an acceptance.
/// </summary>
public record FulfillAcceptanceResult(
    Guid AcceptanceId,
    Guid RequestId,
    string Status,
    bool RequestFulfilled // True if the entire request quota is now met
);