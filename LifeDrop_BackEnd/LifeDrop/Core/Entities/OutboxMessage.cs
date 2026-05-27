using Core.Common;

namespace Core.Entities;

public class OutboxMessage : BaseEntity
{
    public string Type { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public DateTimeOffset? ProcessedOn { get; set; }
    public string? Error { get; set; }
}
