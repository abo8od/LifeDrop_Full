namespace Services.Features.DonationRequests.CancelAcceptance;

public record CancelAcceptanceDto(
    Guid CancellationReasonId,
    string? Note
);