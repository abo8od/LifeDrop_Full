using Core.Common;
using Core.Enums;

using Core.Common.Errors;

namespace Core.Entities;

public class DonationAcceptance : BaseEntity
{
    public Guid DonationRequestId { get; set; }
    public DonationRequest DonationRequest { get; set; } = null!;

    public Guid DonorProfileId { get; set; }
    public DonorProfile DonorProfile { get; set; } = null!;

    public AcceptanceStatus Status { get; set; }

    public DateTime AcceptedAt { get; set; }
    public DateTime? FulfilledAt { get; set; }

    // Cancellation Reason (New)
    public Guid? CancellationReasonId { get; set; }
    public CancellationReason? CancellationReason { get; set; }
    public string? CancellationNote { get; set; }

    // Business Actions
    public Result Fulfill()
    {
        if (Status != AcceptanceStatus.Accepted)
            return Result.Failure(DonationErrors.AcceptanceNotAccepted);

        Status = AcceptanceStatus.Fulfilled;
        FulfilledAt = DateTime.UtcNow;
        return Result.Success();
    }

    public Result CancelByDonor(Guid reasonId, string? note = null)
    {
        if (Status != AcceptanceStatus.Accepted)
            return Result.Failure(DonationErrors.AcceptanceNotAccepted);

        Status = AcceptanceStatus.CancelledByDonor;
        CancellationReasonId = reasonId;
        CancellationNote = note;
        return Result.Success();
    }

    public Result CancelByHospital()
    {
        if (Status != AcceptanceStatus.Accepted)
            return Result.Failure(DonationErrors.AcceptanceNotAccepted);

        Status = AcceptanceStatus.CancelledByHospital;
        return Result.Success();
    }

    public Result MarkAsNoShow()
    {
        if (Status != AcceptanceStatus.Accepted)
            return Result.Failure(DonationErrors.AcceptanceNotAccepted);

        Status = AcceptanceStatus.NoShow;
        return Result.Success();
    }
}