using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class GovernorateConfiguration : IEntityTypeConfiguration<Governorate>
{
    public void Configure(EntityTypeBuilder<Governorate> builder)
    {
        builder.ToTable("Governorates");

        builder.HasKey(g => g.Id);

        builder.Property(g => g.NameAr)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(g => g.NameEn)
            .IsRequired()
            .HasMaxLength(100);

        builder.Ignore(g => g.Name);

        builder.HasMany(g => g.Districts)
            .WithOne(d => d.Governorate)
            .HasForeignKey(d => d.GovernorateId)
            .OnDelete(DeleteBehavior.Restrict);

        // Seed Data: Jordan Governorates
        builder.HasData(
            new Governorate { Id = Guid.Parse("3f7c9c2e-8a4d-4b7e-b1c2-9e5a6f3d2c11"), NameAr = "عمّان", NameEn = "Amman" },
            new Governorate { Id = Guid.Parse("9a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d"), NameAr = "إربد", NameEn = "Irbid" },
            new Governorate { Id = Guid.Parse("8b1c2d3e-4f5a-6b7c-8d9e-0f1a2b3c4d5e"), NameAr = "الزرقاء", NameEn = "Zarqa" }
        );
    }
}
