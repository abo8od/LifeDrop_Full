using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class PointTransactionConfiguration : IEntityTypeConfiguration<PointTransaction>
{
    public void Configure(EntityTypeBuilder<PointTransaction> builder)
    {
        builder.ToTable("PointTransactions");

        builder.HasKey(pt => pt.Id);

        builder.Property(pt => pt.ActionType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(pt => pt.Description)
            .IsRequired()
            .HasMaxLength(255);

        builder.HasOne(pt => pt.DonorProfile)
            .WithMany()
            .HasForeignKey(pt => pt.DonorProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasIndex(pt => pt.DonorProfileId);
        builder.HasIndex(pt => pt.CreatedOn);
    }
}
