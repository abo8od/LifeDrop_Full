using Core.Entities;
using Core.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class DonationRequestConfiguration : IEntityTypeConfiguration<DonationRequest>
{
    public void Configure(EntityTypeBuilder<DonationRequest> builder)
    {
        builder.ToTable("DonationRequests");

        builder.HasKey(r => r.Id);

        builder.HasOne(r => r.Hospital)
            .WithMany(h => h.DonationRequests)
            .HasForeignKey(r => r.HospitalId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(r => r.CreatedByUser)
            .WithMany()
            .HasForeignKey(r => r.CreatedByUserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Property(r => r.BloodType)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(r => r.Urgency)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(r => r.Status)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(r => r.TargetQuota)
            .IsRequired();

        builder.Property(r => r.CurrentActiveAcceptances)
            .HasDefaultValue(0);

        builder.Property(r => r.CurrentFulfilledAcceptances)
            .HasDefaultValue(0);

        // PostgreSQL specific Concurrency Token
        // We configure RowVersion to map to the hidden 'xmin' system column in PostgreSQL
        builder.Property(r => r.RowVersion)
               .HasColumnName("xmin")
               .HasColumnType("xid")
               .IsRowVersion();

        // Partial covering index for the donor feed query:
        // WHERE Status = 'Active' AND BloodType IN (...) AND ExpiryDate > NOW()
        // The partial filter pre-eliminates inactive/fulfilled rows from the index, keeping it small.
        builder.HasIndex(r => new { r.BloodType, r.Urgency, r.ExpiryDate })
            .HasFilter("\"Status\" = 'Active'")
            .HasDatabaseName("ix_donationrequests_active_feed");

        builder.HasIndex(r => r.CreatedOn);
        builder.HasIndex(r => r.ExpiryDate);
        builder.HasIndex(r => r.HospitalId);
    }
}