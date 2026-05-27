using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddLocalizationToCancellationReasons : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "DisplayName",
                table: "CancellationReasons",
                newName: "DisplayNameEn");

            migrationBuilder.AddColumn<string>(
                name: "DisplayNameAr",
                table: "CancellationReasons",
                type: "character varying(200)",
                maxLength: 200,
                nullable: false,
                defaultValue: "");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("11111111-1111-1111-1111-111111111111"),
                columns: new[] { "DisplayNameAr", "DisplayNameEn" },
                values: new object[] { "عذر صحي طارئ (زكام، حرارة، إلخ)", "Emergency health issue (cold, fever, etc.)" });

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("22222222-2222-2222-2222-222222222222"),
                columns: new[] { "DisplayNameAr", "DisplayNameEn" },
                values: new object[] { "تغيير مفاجئ في المواعيد أو ظروف عمل", "Sudden change in schedule or work conditions" });

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("33333333-3333-3333-3333-333333333333"),
                columns: new[] { "DisplayNameAr", "DisplayNameEn" },
                values: new object[] { "صعوبة في المواصلات أو بعد المسافة", "Difficulty in transportation or long distance" });

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("44444444-4444-4444-4444-444444444444"),
                columns: new[] { "DisplayNameAr", "DisplayNameEn" },
                values: new object[] { "اكتشفت أنني غير لائق طبياً للتبرع حالياً", "Discovered I am currently medically ineligible for donation" });

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("55555555-5555-5555-5555-555555555555"),
                columns: new[] { "DisplayNameAr", "DisplayNameEn" },
                values: new object[] { "خوف أو توتر من عملية التبرع", "Fear or anxiety about the donation process" });

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("99999999-9999-9999-9999-999999999999"),
                columns: new[] { "DisplayNameAr", "DisplayNameEn" },
                values: new object[] { "أخرى (يرجى التوضيح)", "Other (please explain)" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DisplayNameAr",
                table: "CancellationReasons");

            migrationBuilder.RenameColumn(
                name: "DisplayNameEn",
                table: "CancellationReasons",
                newName: "DisplayName");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("11111111-1111-1111-1111-111111111111"),
                column: "DisplayName",
                value: "عذر صحي طارئ (زكام، حرارة، إلخ)");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("22222222-2222-2222-2222-222222222222"),
                column: "DisplayName",
                value: "تغيير مفاجئ في المواعيد أو ظروف عمل");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("33333333-3333-3333-3333-333333333333"),
                column: "DisplayName",
                value: "صعوبة في المواصلات أو بعد المسافة");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("44444444-4444-4444-4444-444444444444"),
                column: "DisplayName",
                value: "اكتشفت أنني غير لائق طبياً للتبرع حالياً");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("55555555-5555-5555-5555-555555555555"),
                column: "DisplayName",
                value: "خوف أو توتر من عملية التبرع");

            migrationBuilder.UpdateData(
                table: "CancellationReasons",
                keyColumn: "Id",
                keyValue: new Guid("99999999-9999-9999-9999-999999999999"),
                column: "DisplayName",
                value: "أخرى (يرجى التوضيح)");
        }
    }
}
