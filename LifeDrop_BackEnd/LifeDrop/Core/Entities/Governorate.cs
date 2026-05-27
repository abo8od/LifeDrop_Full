namespace Core.Entities;

public class Governorate : BaseEntity
{
    public string NameAr { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string Name => NameAr; // Prefer Arabic as requested


    public ICollection<District> Districts { get; set; } = new List<District>();
}
