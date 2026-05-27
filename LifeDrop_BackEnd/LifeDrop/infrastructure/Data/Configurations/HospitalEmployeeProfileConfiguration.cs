using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class HospitalEmployeeProfileConfiguration : IEntityTypeConfiguration<HospitalEmployeeProfile>
{
    public void Configure(EntityTypeBuilder<HospitalEmployeeProfile> builder)
    {
        builder.ToTable("HospitalEmployeeProfiles");

        builder.HasKey(p => p.Id);

        builder.HasOne(p => p.User)
            .WithOne(u => u.HospitalEmployeeProfile)
            .HasForeignKey<HospitalEmployeeProfile>(p => p.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(p => p.Hospital)
            .WithMany(h => h.Employees)
            .HasForeignKey(p => p.HospitalId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
