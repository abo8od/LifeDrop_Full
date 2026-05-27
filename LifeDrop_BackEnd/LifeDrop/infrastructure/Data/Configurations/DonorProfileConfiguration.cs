using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class DonorProfileConfiguration : IEntityTypeConfiguration<DonorProfile>
{
    public void Configure(EntityTypeBuilder<DonorProfile> builder)
    {
        builder.ToTable("DonorProfiles");

        builder.HasKey(p => p.Id);

        builder.Property(p => p.BloodType)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.HasOne(p => p.Governorate)
            .WithMany()
            .HasForeignKey(p => p.GovernorateId)
            .OnDelete(DeleteBehavior.SetNull);

        builder.HasOne(p => p.District)
            .WithMany()
            .HasForeignKey(p => p.DistrictId)
            .OnDelete(DeleteBehavior.SetNull);

        builder.HasOne(p => p.User)
            .WithOne(u => u.DonorProfile)
            .HasForeignKey<DonorProfile>(p => p.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.Property(p => p.IsAvailable)
            .HasDefaultValue(true);

        builder.Property(p => p.ReliabilityScore)
            .HasDefaultValue(100.0);

        builder.Property(p => p.GamificationPoints)
            .HasDefaultValue(0);

        builder.HasIndex(p => p.UserId)
            .IsUnique();

        builder.HasIndex(p => p.GovernorateId);

        builder.HasIndex(p => new { p.GamificationPoints, p.ReliabilityScore });

        builder.Property(p => p.EligibilityNotificationSentFor)
            .IsRequired(false);
    }
}
