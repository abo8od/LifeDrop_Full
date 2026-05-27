using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class DeviceTokenConfiguration : IEntityTypeConfiguration<DeviceToken>
{
    public void Configure(EntityTypeBuilder<DeviceToken> builder)
    {
        builder.ToTable("DeviceTokens");

        builder.HasKey(d => d.Id);

        builder.Property(d => d.Token)
            .IsRequired()
            .HasMaxLength(512);

        builder.Property(d => d.Platform)
            .HasConversion<string>()
            .HasMaxLength(20);

        // One token per device — enforce uniqueness on the token itself
        builder.HasIndex(d => d.Token).IsUnique();

        // Fast lookup: "give me all tokens for user X"
        builder.HasIndex(d => d.UserId);

        builder.HasOne(d => d.User)
            .WithMany()
            .HasForeignKey(d => d.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
