using Core.Common;
using MediatR;

namespace Services.Features.DonationRequests.MarkAcceptanceNoShow;

/// <summary>
/// Command for hospital employee to mark a donor's acceptance as no-show (did not arrive).
/// </summary>
public record MarkAcceptanceNoShowCommand(
    Guid AcceptanceId
) : IRequest<Result<MarkAcceptanceNoShowResult>>;

/// <summary>
/// Result of marking acceptance as no-show.
/// </summary>
public record MarkAcceptanceNoShowResult(
    Guid AcceptanceId,
    Guid RequestId,
    string Status
);