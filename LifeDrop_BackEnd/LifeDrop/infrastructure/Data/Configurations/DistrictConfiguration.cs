using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class DistrictConfiguration : IEntityTypeConfiguration<District>
{
    public void Configure(EntityTypeBuilder<District> builder)
    {
        builder.ToTable("Districts");

        builder.HasKey(d => d.Id);

        builder.Property(d => d.NameAr)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(d => d.NameEn)
            .IsRequired()
            .HasMaxLength(100);

        builder.Ignore(d => d.Name);

        builder.HasOne(d => d.Governorate)
            .WithMany(g => g.Districts)
            .HasForeignKey(d => d.GovernorateId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(d => d.GovernorateId);

        // Seed Data: Jordan Districts
        var ammanId = Guid.Parse("3f7c9c2e-8a4d-4b7e-b1c2-9e5a6f3d2c11");
        var irbidId = Guid.Parse("9a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d");
        var zarqaId = Guid.Parse("8b1c2d3e-4f5a-6b7c-8d9e-0f1a2b3c4d5e");

        builder.HasData(
            // Amman Districts
            new District { Id = Guid.Parse("a8b4f1d9-3c72-4e6a-9f15-2b7c8d0e4a63"), NameAr = "لواء الجامعة", NameEn = "University District", GovernorateId = ammanId },
            new District { Id = Guid.Parse("c5d6e7f8-9a0b-1c2d-3e4f-5a6b7c8d9e0f"), NameAr = "ماركا", NameEn = "Marka", GovernorateId = ammanId },
            new District { Id = Guid.Parse("d6e7f8a9-0b1c-2d3e-4f5a-6b7c8d9e0f1a"), NameAr = "ناعور", NameEn = "Naour", GovernorateId = ammanId },
            new District { Id = Guid.Parse("e7f8a9b0-1c2d-3e4f-5a6b-7c8d9e0f1a2b"), NameAr = "صويلح", NameEn = "Sweileh", GovernorateId = ammanId },

            // Irbid Districts
            new District { Id = Guid.Parse("f8a9b0c1-2d3e-4f5a-6b7c-8d9e0f1a2b3c"), NameAr = "لواء قصبة إربد", NameEn = "Irbid City", GovernorateId = irbidId },
            new District { Id = Guid.Parse("a9b0c1d2-3e4f-5a6b-7c8d-9e0f1a2b3c4d"), NameAr = "الرمثا", NameEn = "Ramtha", GovernorateId = irbidId },
            new District { Id = Guid.Parse("b0c1d2e3-4f5a-6b7c-8d9e-0f1a2b3c4d5e"), NameAr = "الطيبة", NameEn = "Taybeh", GovernorateId = irbidId },

            // Zarqa Districts
            new District { Id = Guid.Parse("c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f"), NameAr = "قصبة الزرقاء", NameEn = "Zarqa City", GovernorateId = zarqaId },
            new District { Id = Guid.Parse("d2e3f4a5-6b7c-8d9e-0f1a-2b3c4d5e6f7a"), NameAr = "الرصيفة", NameEn = "Ruseifa", GovernorateId = zarqaId },
            new District { Id = Guid.Parse("e3f4a5b6-7c8d-9e0f-1a2b-3c4d5e6f7a8b"), NameAr = "الهاشمية", NameEn = "Hashmi", GovernorateId = zarqaId }
        );
    }
}
