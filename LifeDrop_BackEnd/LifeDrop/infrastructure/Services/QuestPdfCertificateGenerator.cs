using LifeDrop.Services.Abstractions;
using LifeDrop.Services.DTOs;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;
using System;

namespace Infrastructure.Services;

public class QuestPdfCertificateGenerator : IPdfCertificateGenerator
{
    public QuestPdfCertificateGenerator()
    {
        QuestPDF.Settings.License = LicenseType.Community;
    }

    public byte[] Generate(CertificateDataDto data)
    {
        // Generate a short, nice-looking reference from the UUID
        var shortId = data.CertificateId.Length >= 8 
            ? data.CertificateId.Substring(0, 8).ToUpper() 
            : data.CertificateId;
            
        var refNumber = $"LD-{DateTime.UtcNow.Year}-{shortId}";

        var document = Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4.Landscape());
                page.Margin(0);
                page.PageColor(Colors.White);

                page.Content().Layers(layers =>
                {
                    // Layer 0: Background
                    layers.Layer().Background("#FAFAFA"); // Very light modern grey

                    // Layer 1: Left Accent Strip (Brand Color)
                    layers.Layer().Row(row =>
                    {
                        row.ConstantItem(40).Background("#D32F2F"); // Deep Red Strip
                        row.RelativeItem().Background(Colors.Transparent);
                    });

                    // Layer 2: Outer Frame
                    layers.Layer().Padding(25).Border(1).BorderColor("#E0E0E0");
                    layers.Layer().Padding(32).Border(2).BorderColor("#D32F2F");

                    // Layer 3: Large Watermark
                    layers.Layer()
                        .AlignCenter()
                        .AlignMiddle()
                        .Text("LIFE DROP")
                        .FontSize(140)
                        .FontColor("#FFF0F0") // Extremely subtle pink/red watermark
                        .Bold();

                    // Layer 4: Main Content
                    layers.PrimaryLayer()
                        .PaddingLeft(70) // Push content away from the left red strip
                        .PaddingRight(40)
                        .PaddingTop(40)
                        .PaddingBottom(40)
                        .Column(col =>
                        {
                            col.Spacing(6);

                            // Header Section
                            col.Item().Row(row =>
                            {
                                row.RelativeItem().AlignLeft().Text("LIFE DROP INITIATIVE")
                                    .FontSize(14).Bold().FontColor("#D32F2F").LetterSpacing(0.1f);
                                    
                                row.RelativeItem().AlignRight().Text($"Ref: {refNumber}")
                                    .FontSize(10).FontColor(Colors.Grey.Medium);
                            });

                            col.Item().PaddingTop(20).AlignCenter().Text("CERTIFICATE OF APPRECIATION")
                                .FontSize(38)
                                .Bold()
                                .FontColor("#B71C1C")
                                .LetterSpacing(0.05f);

                            col.Item().PaddingTop(5).AlignCenter().Text("IS PROUDLY PRESENTED TO")
                                .FontSize(14)
                                .FontColor(Colors.Grey.Darken2)
                                .LetterSpacing(0.2f);

                            // Donor Name
                            col.Item().PaddingTop(20).AlignCenter().Text(data.DonorName.ToUpper())
                                .FontSize(48)
                                .Bold()
                                .FontColor("#0D47A1"); // Deep Royal Blue

                            // Description
                            col.Item().PaddingTop(20).AlignCenter().Text(text =>
                            {
                                text.Span("In sincere appreciation of your selfless and life-saving gift of ").FontSize(16).FontColor(Colors.Grey.Darken3);
                                text.Span($"Blood Type {data.BloodType}").FontSize(16).Bold().FontColor("#D32F2F");
                                text.Span(". \nYour generosity gives hope and life to those in need.").FontSize(16).FontColor(Colors.Grey.Darken3);
                            });

                            col.Item().PaddingTop(15).AlignCenter().Text($"Donated at: {data.HospitalName}")
                                .FontSize(14).FontColor(Colors.Grey.Darken2).SemiBold();

                            col.Item().AlignCenter().Text($"Date: {data.Date:MMMM dd, yyyy}")
                                .FontSize(14).FontColor(Colors.Grey.Darken2);

                            // Footer: Signatures and Seal
                            col.Item().PaddingTop(35).Row(row =>
                            {
                                // Left Signature
                                row.RelativeItem().AlignLeft().AlignBottom().Column(c =>
                                {
                                    c.Item().Width(180).LineHorizontal(1).LineColor(Colors.Grey.Medium);
                                    c.Item().PaddingTop(5).Text("Hospital Administrator").FontSize(11).FontColor(Colors.Grey.Darken1);
                                });

                                // Center Seal
                                row.RelativeItem().AlignCenter().AlignMiddle().Column(c =>
                                {
                                    c.Item().Width(80).Height(80).AlignCenter().AlignMiddle()
                                        .Background("#D32F2F") // Red box acting as a seal
                                        .Padding(5)
                                        .Border(2).BorderColor(Colors.White) // inner white line
                                        .AlignCenter().AlignMiddle()
                                        .Text("OFFICIAL\nSEAL")
                                        .AlignCenter()
                                        .FontSize(10)
                                        .Bold()
                                        .FontColor(Colors.White);
                                });

                                // Right Signature
                                row.RelativeItem().AlignRight().AlignBottom().Column(c =>
                                {
                                    c.Item().Width(180).LineHorizontal(1).LineColor(Colors.Grey.Medium);
                                    c.Item().PaddingTop(5).Text("LifeDrop Director").FontSize(11).FontColor(Colors.Grey.Darken1);
                                });
                            });
                        });
                });
            });
        });

        return document.GeneratePdf();
    }
}