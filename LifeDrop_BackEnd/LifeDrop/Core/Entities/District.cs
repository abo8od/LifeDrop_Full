namespace Core.Entities;

public class District : BaseEntity
{
    public string NameAr { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string Name => NameAr; // Prefer Arabic as requested

    public Guid GovernorateId { get; set; }
    public Governorate Governorate { get; set; } = null!;
}
