using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddMorePerformanceIndexes : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_DonationRequests_BloodType",
                table: "DonationRequests");

            migrationBuilder.DropIndex(
                name: "IX_DonationRequests_Status",
                table: "DonationRequests");

            migrationBuilder.DropIndex(
                name: "IX_DonationAcceptances_DonorProfileId",
                table: "DonationAcceptances");

            migrationBuilder.DropIndex(
                name: "IX_DonationAcceptances_Status",
                table: "DonationAcceptances");

            migrationBuilder.AlterColumn<string>(
                name: "PhoneNumber",
                table: "PendingRegistrations",
                type: "character varying(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "PasswordHash",
                table: "PendingRegistrations",
                type: "character varying(500)",
                maxLength: 500,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "OtpCode",
                table: "PendingRegistrations",
                type: "character varying(6)",
                maxLength: 6,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "LastName",
                table: "PendingRegistrations",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "FirstName",
                table: "PendingRegistrations",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "PendingRegistrations",
                type: "character varying(256)",
                maxLength: 256,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "BloodType",
                table: "PendingRegistrations",
                type: "character varying(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer");

            migrationBuilder.CreateIndex(
                name: "IX_PendingRegistrations_Email",
                table: "PendingRegistrations",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DonationRequests_CreatedOn",
                table: "DonationRequests",
                column: "CreatedOn");

            migrationBuilder.CreateIndex(
                name: "IX_DonationRequests_Status_BloodType",
                table: "DonationRequests",
                columns: new[] { "Status", "BloodType" });

            migrationBuilder.CreateIndex(
                name: "IX_DonationAcceptances_DonorProfileId_Status",
                table: "DonationAcceptances",
                columns: new[] { "DonorProfileId", "Status" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_PendingRegistrations_Email",
                table: "PendingRegistrations");

            migrationBuilder.DropIndex(
                name: "IX_DonationRequests_CreatedOn",
                table: "DonationRequests");

            migrationBuilder.DropIndex(
                name: "IX_DonationRequests_Status_BloodType",
                table: "DonationRequests");

            migrationBuilder.DropIndex(
                name: "IX_DonationAcceptances_DonorProfileId_Status",
                table: "DonationAcceptances");

            migrationBuilder.AlterColumn<string>(
                name: "PhoneNumber",
                table: "PendingRegistrations",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<string>(
                name: "PasswordHash",
                table: "PendingRegistrations",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(500)",
                oldMaxLength: 500);

            migrationBuilder.AlterColumn<string>(
                name: "OtpCode",
                table: "PendingRegistrations",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(6)",
                oldMaxLength: 6);

            migrationBuilder.AlterColumn<string>(
                name: "LastName",
                table: "PendingRegistrations",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "FirstName",
                table: "PendingRegistrations",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "PendingRegistrations",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(256)",
                oldMaxLength: 256);

            migrationBuilder.AlterColumn<int>(
                name: "BloodType",
                table: "PendingRegistrations",
                type: "integer",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(20)",
                oldMaxLength: 20);

            migrationBuilder.CreateIndex(
                name: "IX_DonationRequests_BloodType",
                table: "DonationRequests",
                column: "BloodType");

            migrationBuilder.CreateIndex(
                name: "IX_DonationRequests_Status",
                table: "DonationRequests",
                column: "Status");

            migrationBuilder.CreateIndex(
                name: "IX_DonationAcceptances_DonorProfileId",
                table: "DonationAcceptances",
                column: "DonorProfileId");

            migrationBuilder.CreateIndex(
                name: "IX_DonationAcceptances_Status",
                table: "DonationAcceptances",
                column: "Status");
        }
    }
}
