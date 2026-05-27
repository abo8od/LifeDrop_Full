using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FulfilledAtIndex : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "ix_donationacceptances_fulfilled_last",
                table: "DonationAcceptances",
                columns: new[] { "DonorProfileId", "FulfilledAt" },
                descending: new[] { false, true },
                filter: "\"Status\" = 'Fulfilled'");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_donationacceptances_fulfilled_last",
                table: "DonationAcceptances");
        }
    }
}
