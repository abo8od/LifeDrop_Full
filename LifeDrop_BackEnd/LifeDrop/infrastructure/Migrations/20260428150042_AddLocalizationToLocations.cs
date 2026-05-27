using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddLocalizationToLocations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Name",
                table: "Governorates",
                newName: "NameEn");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "Districts",
                newName: "NameEn");

            migrationBuilder.AddColumn<string>(
                name: "NameAr",
                table: "Governorates",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "NameAr",
                table: "Districts",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("a8b4f1d9-3c72-4e6a-9f15-2b7c8d0e4a63"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "لواء الجامعة", "University District" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("a9b0c1d2-3e4f-5a6b-7c8d-9e0f1a2b3c4d"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "الرمثا", "Ramtha" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("b0c1d2e3-4f5a-6b7c-8d9e-0f1a2b3c4d5e"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "الطيبة", "Taybeh" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "قصبة الزرقاء", "Zarqa City" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("c5d6e7f8-9a0b-1c2d-3e4f-5a6b7c8d9e0f"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "ماركا", "Marka" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("d2e3f4a5-6b7c-8d9e-0f1a-2b3c4d5e6f7a"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "الرصيفة", "Ruseifa" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("d6e7f8a9-0b1c-2d3e-4f5a-6b7c8d9e0f1a"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "ناعور", "Naour" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("e3f4a5b6-7c8d-9e0f-1a2b-3c4d5e6f7a8b"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "الهاشمية", "Hashmi" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("e7f8a9b0-1c2d-3e4f-5a6b-7c8d9e0f1a2b"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "صويلح", "Sweileh" });

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("f8a9b0c1-2d3e-4f5a-6b7c-8d9e0f1a2b3c"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "لواء قصبة إربد", "Irbid City" });

            migrationBuilder.UpdateData(
                table: "Governorates",
                keyColumn: "Id",
                keyValue: new Guid("3f7c9c2e-8a4d-4b7e-b1c2-9e5a6f3d2c11"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "عمّان", "Amman" });

            migrationBuilder.UpdateData(
                table: "Governorates",
                keyColumn: "Id",
                keyValue: new Guid("8b1c2d3e-4f5a-6b7c-8d9e-0f1a2b3c4d5e"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "الزرقاء", "Zarqa" });

            migrationBuilder.UpdateData(
                table: "Governorates",
                keyColumn: "Id",
                keyValue: new Guid("9a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d"),
                columns: new[] { "NameAr", "NameEn" },
                values: new object[] { "إربد", "Irbid" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NameAr",
                table: "Governorates");

            migrationBuilder.DropColumn(
                name: "NameAr",
                table: "Districts");

            migrationBuilder.RenameColumn(
                name: "NameEn",
                table: "Governorates",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "NameEn",
                table: "Districts",
                newName: "Name");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("a8b4f1d9-3c72-4e6a-9f15-2b7c8d0e4a63"),
                column: "Name",
                value: "لواء الجامعة (University District)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("a9b0c1d2-3e4f-5a6b-7c8d-9e0f1a2b3c4d"),
                column: "Name",
                value: "الرمثا (Ramtha)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("b0c1d2e3-4f5a-6b7c-8d9e-0f1a2b3c4d5e"),
                column: "Name",
                value: "الطيبة (Taybeh)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f"),
                column: "Name",
                value: "قصبة الزرقاء (Zarqa City)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("c5d6e7f8-9a0b-1c2d-3e4f-5a6b7c8d9e0f"),
                column: "Name",
                value: "ماركا (Marka)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("d2e3f4a5-6b7c-8d9e-0f1a-2b3c4d5e6f7a"),
                column: "Name",
                value: "الرصيفة (Ruseifa)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("d6e7f8a9-0b1c-2d3e-4f5a-6b7c8d9e0f1a"),
                column: "Name",
                value: "ناعور (Naour)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("e3f4a5b6-7c8d-9e0f-1a2b-3c4d5e6f7a8b"),
                column: "Name",
                value: "الهاشمية (Hashmi)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("e7f8a9b0-1c2d-3e4f-5a6b-7c8d9e0f1a2b"),
                column: "Name",
                value: "صويلح (Sweileh)");

            migrationBuilder.UpdateData(
                table: "Districts",
                keyColumn: "Id",
                keyValue: new Guid("f8a9b0c1-2d3e-4f5a-6b7c-8d9e0f1a2b3c"),
                column: "Name",
                value: "لواء قصبة إربد (Irbid City)");

            migrationBuilder.UpdateData(
                table: "Governorates",
                keyColumn: "Id",
                keyValue: new Guid("3f7c9c2e-8a4d-4b7e-b1c2-9e5a6f3d2c11"),
                column: "Name",
                value: "عمّان (Amman)");

            migrationBuilder.UpdateData(
                table: "Governorates",
                keyColumn: "Id",
                keyValue: new Guid("8b1c2d3e-4f5a-6b7c-8d9e-0f1a2b3c4d5e"),
                column: "Name",
                value: "الزرقاء (Zarqa)");

            migrationBuilder.UpdateData(
                table: "Governorates",
                keyColumn: "Id",
                keyValue: new Guid("9a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d"),
                column: "Name",
                value: "إربد (Irbid)");
        }
    }
}
