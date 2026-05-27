using Core.Common;
using Services.Interfaces;

namespace Services.Features.DonationRequests.AcceptDonationRequest;

public record AcceptDonationRequestCommand(
    Guid DonationRequestId,
    Guid RequestId // Idempotency Key
) : IIdempotentCommand<Result<AcceptDonationRequestResult>>;

public record AcceptDonationRequestResult(
    Guid AcceptanceId,
    Guid RequestId,
    string Status
);