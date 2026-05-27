using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddDonationAcceptanceStatusAcceptedAtIndex : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_DonationAcceptances_Status_AcceptedAt",
                table: "DonationAcceptances",
                columns: new[] { "Status", "AcceptedAt" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_DonationAcceptances_Status_AcceptedAt",
                table: "DonationAcceptances");
        }
    }
}
