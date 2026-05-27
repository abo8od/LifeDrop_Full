namespace Core.Entities;

public class HospitalEmployeeProfile : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public Guid HospitalId { get; set; }
    public Hospital Hospital { get; set; } = null!;
}
