using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Data.Configurations;

public class CancellationReasonConfiguration : IEntityTypeConfiguration<CancellationReason>
{
    public void Configure(EntityTypeBuilder<CancellationReason> builder)
    {
        builder.ToTable("CancellationReasons");

        builder.HasKey(r => r.Id);

        builder.Property(r => r.Code)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(r => r.DisplayNameAr)
            .IsRequired()
            .HasMaxLength(200);

        builder.Property(r => r.DisplayNameEn)
            .IsRequired()
            .HasMaxLength(200);

        builder.Ignore(r => r.DisplayName);

        builder.HasIndex(r => r.Code).IsUnique();
        builder.HasIndex(r => r.IsActive);
        builder.HasIndex(r => r.DisplayOrder);

        // Seeding Real-world Cancellation Reasons
        builder.HasData(
            new CancellationReason 
            { 
                Id = Guid.Parse("11111111-1111-1111-1111-111111111111"), 
                Code = "HEALTH_ISSUE", 
                DisplayNameAr = "عذر صحي طارئ (زكام، حرارة، إلخ)", 
                DisplayNameEn = "Emergency health issue (cold, fever, etc.)",
                DisplayOrder = 1, 
                IsActive = true 
            },
            new CancellationReason 
            { 
                Id = Guid.Parse("22222222-2222-2222-2222-222222222222"), 
                Code = "SCHEDULE_CONFLICT", 
                DisplayNameAr = "تغيير مفاجئ في المواعيد أو ظروف عمل", 
                DisplayNameEn = "Sudden change in schedule or work conditions",
                DisplayOrder = 2, 
                IsActive = true 
            },
            new CancellationReason 
            { 
                Id = Guid.Parse("33333333-3333-3333-3333-333333333333"), 
                Code = "TRANSPORTATION_ISSUE", 
                DisplayNameAr = "صعوبة في المواصلات أو بعد المسافة", 
                DisplayNameEn = "Difficulty in transportation or long distance",
                DisplayOrder = 3, 
                IsActive = true 
            },
            new CancellationReason 
            { 
                Id = Guid.Parse("44444444-4444-4444-4444-444444444444"), 
                Code = "MEDICAL_INELIGIBILITY", 
                DisplayNameAr = "اكتشفت أنني غير لائق طبياً للتبرع حالياً", 
                DisplayNameEn = "Discovered I am currently medically ineligible for donation",
                DisplayOrder = 4, 
                IsActive = true 
            },
            new CancellationReason 
            { 
                Id = Guid.Parse("55555555-5555-5555-5555-555555555555"), 
                Code = "FEAR_OR_ANXIETY", 
                DisplayNameAr = "خوف أو توتر من عملية التبرع", 
                DisplayNameEn = "Fear or anxiety about the donation process",
                DisplayOrder = 5, 
                IsActive = true 
            },
            new CancellationReason 
            { 
                Id = Guid.Parse("99999999-9999-9999-9999-999999999999"), 
                Code = "OTHER", 
                DisplayNameAr = "أخرى (يرجى التوضيح)", 
                DisplayNameEn = "Other (please explain)",
                DisplayOrder = 99, 
                IsActive = true 
            }
        );
    }
}
