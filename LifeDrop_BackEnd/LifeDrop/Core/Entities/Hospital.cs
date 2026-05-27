using Core.Common;

namespace Core.Entities;

public class Hospital : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string Address { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public bool IsVerified { get; set; }

    public ICollection<HospitalEmployeeProfile> Employees { get; set; } = new List<HospitalEmployeeProfile>();
    public ICollection<DonationRequest> DonationRequests { get; set; } = new List<DonationRequest>();

    // Business Actions (State Changes)
    public Result Verify()
    {
        if (IsVerified) return Result.Success();
        IsVerified = true;
        return Result.Success();
    }

    public Result Suspend()
    {
        if (!IsVerified) return Result.Success();
        IsVerified = false;
        return Result.Success();
    }
}
