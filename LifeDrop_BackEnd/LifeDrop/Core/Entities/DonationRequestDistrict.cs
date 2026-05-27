namespace Core.Entities;

public class DonationRequestDistrict
{
    public Guid DonationRequestId { get; set; }
    public DonationRequest DonationRequest { get; set; } = null!;

    public Guid DistrictId { get; set; }
    public District District { get; set; } = null!;
}