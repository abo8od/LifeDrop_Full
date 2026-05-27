using Core.Common;
using MediatR;

namespace Services.Features.DonationRequests.CancelRequest;

/// <summary>
/// Command for hospital employee to cancel an active donation request.
/// </summary>
public record CancelRequestCommand(
    Guid RequestId
) : IRequest<Result<CancelRequestResult>>;

/// <summary>
/// Result of cancelling a request.
/// </summary>
public record CancelRequestResult(
    Guid RequestId,
    string Status
);