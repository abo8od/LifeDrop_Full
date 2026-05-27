using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class HospitalConfiguration : IEntityTypeConfiguration<Hospital>
{
    public void Configure(EntityTypeBuilder<Hospital> builder)
    {
        builder.ToTable("Hospitals");

        builder.HasKey(h => h.Id);

        builder.Property(h => h.Name)
            .IsRequired()
            .HasMaxLength(200);

        builder.HasMany(h => h.Employees)
            .WithOne(e => e.Hospital)
            .HasForeignKey(e => e.HospitalId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasIndex(h => h.IsVerified);
    }
}
