using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class OutboxMessageConfiguration : IEntityTypeConfiguration<OutboxMessage>
{
    public void Configure(EntityTypeBuilder<OutboxMessage> builder)
    {
        builder.ToTable("OutboxMessages");

        builder.HasKey(x => x.Id);

        builder.Property(x => x.Type)
            .IsRequired()
            .HasMaxLength(255);

        builder.Property(x => x.Content)
            .IsRequired()
            .HasColumnType("text"); // JSON content

        builder.Property(x => x.Error)
            .HasColumnType("text");
            
        builder.HasIndex(x => x.ProcessedOn);
        // Partial index: the worker polls WHERE ProcessedOn IS NULL ORDER BY CreatedOn LIMIT 20.
        // This index only contains unprocessed rows, staying tiny regardless of table size.
        builder.HasIndex(x => x.CreatedOn)
            .HasFilter("\"ProcessedOn\" IS NULL")
            .HasDatabaseName("ix_outboxmessages_unprocessed");
    }
}
