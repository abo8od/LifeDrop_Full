using Core.Common;

namespace Core.Entities;

public class IdempotentRequest : BaseEntity
{
    public string Name { get; set; } = string.Empty;
}
