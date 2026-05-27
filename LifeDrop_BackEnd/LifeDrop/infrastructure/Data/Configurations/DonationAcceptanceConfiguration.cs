using Core.Entities;
using Core.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class DonationAcceptanceConfiguration : IEntityTypeConfiguration<DonationAcceptance>
{
    public void Configure(EntityTypeBuilder<DonationAcceptance> builder)
    {
        builder.ToTable("DonationAcceptances");

        builder.HasKey(a => a.Id);

        builder.HasOne(a => a.DonationRequest)
            .WithMany(r => r.Acceptances)
            .HasForeignKey(a => a.DonationRequestId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(a => a.DonorProfile)
            .WithMany(d => d.DonationAcceptances)
            .HasForeignKey(a => a.DonorProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.Property(a => a.Status)
            .HasConversion<string>()
            .HasMaxLength(30);

        builder.HasIndex(a => new { a.DonorProfileId, a.Status });
        builder.HasIndex(a => a.DonationRequestId);

        // Partial index for the home endpoint's LastHospitalName correlated subquery:
        // WHERE Status = 'Fulfilled' ORDER BY FulfilledAt DESC
        builder.HasIndex(a => new { a.DonorProfileId, a.FulfilledAt })
            .IsDescending(false, true)
            .HasFilter("\"Status\" = 'Fulfilled'")
            .HasDatabaseName("ix_donationacceptances_fulfilled_last");
        // Partial index for the timeout worker: WHERE Status = 'Accepted' AND AcceptedAt < cutoff.
        // Stays small because once an acceptance is resolved (NoShow/Fulfilled/Cancelled) it drops out.
        builder.HasIndex(a => a.AcceptedAt)
            .HasFilter("\"Status\" = 'Accepted'")
            .HasDatabaseName("ix_donationacceptances_pending_timeout");

        builder.HasOne(a => a.CancellationReason)
            .WithMany()
            .HasForeignKey(a => a.CancellationReasonId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Property(a => a.CancellationNote)
            .HasMaxLength(500);

    }
}