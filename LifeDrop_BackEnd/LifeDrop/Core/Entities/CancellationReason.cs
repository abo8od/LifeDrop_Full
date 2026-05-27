namespace Core.Entities;

/// <summary>
/// Lookup entity for cancellation reasons.
/// Can be managed by System Admin without code changes.
/// </summary>
public class CancellationReason : BaseEntity
{
    public string Code { get; set; } = string.Empty;
    public string DisplayNameAr { get; set; } = string.Empty;
    public string DisplayNameEn { get; set; } = string.Empty;
    public string DisplayName => DisplayNameAr; // Prefer Arabic as requested

    public bool IsActive { get; set; } = true;
    public int DisplayOrder { get; set; }
}