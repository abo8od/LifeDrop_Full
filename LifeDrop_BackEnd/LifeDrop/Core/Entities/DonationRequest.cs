using Core.Common;
using Core.Enums;

using Core.Common.Errors;

namespace Core.Entities;

public class DonationRequest : BaseEntity
{
    public Guid HospitalId { get; set; }
    public Hospital Hospital { get; set; } = null!;

    public Guid CreatedByUserId { get; set; }
    public User CreatedByUser { get; set; } = null!;

    public BloodType BloodType { get; set; }
    public int TargetQuota { get; set; }
    public int CurrentActiveAcceptances { get; set; }
    public int CurrentFulfilledAcceptances { get; set; }

    public UrgencyLevel Urgency { get; set; }
    public RequestStatus Status { get; set; }

    public DateTime ExpiryDate { get; set; }

    // Optimistic Concurrency Token (for PostgreSQL xmin)
    public uint RowVersion { get; set; }

    // Navigation properties
    public ICollection<DonationRequestDistrict> RequestDistricts { get; set; } = new List<DonationRequestDistrict>();
    public ICollection<DonationAcceptance> Acceptances { get; set; } = new List<DonationAcceptance>();

    // Business Actions
    public Result IncrementActiveAcceptances()
    {
        if (Status != RequestStatus.Active)
            return Result.Failure(DonationErrors.RequestNotActive);

        if (CurrentActiveAcceptances >= TargetQuota)
            return Result.Failure(DonationErrors.QuotaFull);

        CurrentActiveAcceptances++;
        return Result.Success();
    }

    public Result IncrementFulfilledAcceptances()
    {
        if (CurrentFulfilledAcceptances >= TargetQuota)
            return Result.Failure(DonationErrors.RequestAlreadyFulfilled);

        CurrentFulfilledAcceptances++;

        if (CurrentFulfilledAcceptances >= TargetQuota)
        {
            Status = RequestStatus.Fulfilled;
        }

        return Result.Success();
    }

    public Result Cancel()
    {
        if (Status != RequestStatus.Active)
            return Result.Failure(DonationErrors.RequestNotActive);

        Status = RequestStatus.Cancelled;
        return Result.Success();
    }

    public Result MarkAsExpired()
    {
        if (Status != RequestStatus.Active)
            return Result.Failure(DonationErrors.RequestNotActive);

        Status = RequestStatus.Expired;
        return Result.Success();
    }

    public Result DecrementActiveAcceptances()
    {
        if (CurrentActiveAcceptances <= 0)
            return Result.Failure(DonationErrors.NoActiveAcceptances);

        CurrentActiveAcceptances--;
        return Result.Success();
    }
}