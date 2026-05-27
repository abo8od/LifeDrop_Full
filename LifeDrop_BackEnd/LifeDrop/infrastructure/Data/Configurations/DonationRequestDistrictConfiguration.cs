using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class DonationRequestDistrictConfiguration : IEntityTypeConfiguration<DonationRequestDistrict>
{
    public void Configure(EntityTypeBuilder<DonationRequestDistrict> builder)
    {
        builder.ToTable("DonationRequestDistricts");

        builder.HasKey(x => new { x.DonationRequestId, x.DistrictId });

        builder.HasOne(x => x.DonationRequest)
            .WithMany(r => r.RequestDistricts)
            .HasForeignKey(x => x.DonationRequestId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(x => x.District)
            .WithMany()
            .HasForeignKey(x => x.DistrictId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasIndex(x => x.DistrictId);
    }
}