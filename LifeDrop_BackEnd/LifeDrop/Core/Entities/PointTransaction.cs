using System;

namespace Core.Entities;

public class PointTransaction : BaseEntity
{
    public Guid DonorProfileId { get; set; }
    public DonorProfile DonorProfile { get; set; } = null!;

    public int Points { get; set; }
    public string ActionType { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public Guid? ReferenceId { get; set; }
}
