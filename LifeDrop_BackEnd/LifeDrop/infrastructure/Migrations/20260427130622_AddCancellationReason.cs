using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddCancellationReason : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CancellationNote",
                table: "DonationAcceptances",
                type: "character varying(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "CancellationReasonId",
                table: "DonationAcceptances",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "CancellationReasons",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Code = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    DisplayName = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    IsActive = table.Column<bool>(type: "boolean", nullable: false),
                    DisplayOrder = table.Column<int>(type: "integer", nullable: false),
                    CreatedBy = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedOn = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    ModifiedOn = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    ModifiedBy = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CancellationReasons", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DonationAcceptances_CancellationReasonId",
                table: "DonationAcceptances",
                column: "CancellationReasonId");

            migrationBuilder.CreateIndex(
                name: "IX_CancellationReasons_Code",
                table: "CancellationReasons",
                column: "Code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CancellationReasons_DisplayOrder",
                table: "CancellationReasons",
                column: "DisplayOrder");

            migrationBuilder.CreateIndex(
                name: "IX_CancellationReasons_IsActive",
                table: "CancellationReasons",
                column: "IsActive");

            migrationBuilder.AddForeignKey(
                name: "FK_DonationAcceptances_CancellationReasons_CancellationReasonId",
                table: "DonationAcceptances",
                column: "CancellationReasonId",
                principalTable: "CancellationReasons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DonationAcceptances_CancellationReasons_CancellationReasonId",
                table: "DonationAcceptances");

            migrationBuilder.DropTable(
                name: "CancellationReasons");

            migrationBuilder.DropIndex(
                name: "IX_DonationAcceptances_CancellationReasonId",
                table: "DonationAcceptances");

            migrationBuilder.DropColumn(
                name: "CancellationNote",
                table: "DonationAcceptances");

            migrationBuilder.DropColumn(
                name: "CancellationReasonId",
                table: "DonationAcceptances");
        }
    }
}
