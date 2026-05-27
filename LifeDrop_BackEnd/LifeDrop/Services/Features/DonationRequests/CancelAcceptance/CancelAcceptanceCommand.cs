using Core.Common;
using MediatR;

namespace Services.Features.DonationRequests.CancelAcceptance;

/// <summary>
/// Command for a donor to cancel their acceptance of a donation request.
/// </summary>
public record CancelAcceptanceCommand(
    Guid RequestId,
    Guid CancellationReasonId,
    string? Note
) : IRequest<Result<CancelAcceptanceResult>>;

/// <summary>
/// Result of cancelling an acceptance.
/// </summary>
public record CancelAcceptanceResult(
    Guid RequestId,
    string Status
);