using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class PerformanceIndexOptimizations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_OutboxMessages_CreatedOn",
                table: "OutboxMessages");

            migrationBuilder.DropIndex(
                name: "IX_DonationRequests_Status_BloodType",
                table: "DonationRequests");

            migrationBuilder.DropIndex(
                name: "IX_DonationAcceptances_Status_AcceptedAt",
                table: "DonationAcceptances");

            migrationBuilder.CreateIndex(
                name: "ix_outboxmessages_unprocessed",
                table: "OutboxMessages",
                column: "CreatedOn",
                filter: "\"ProcessedOn\" IS NULL");

            migrationBuilder.CreateIndex(
                name: "IX_IdempotentRequests_CreatedOn",
                table: "IdempotentRequests",
                column: "CreatedOn");

            migrationBuilder.CreateIndex(
                name: "ix_donationrequests_active_feed",
                table: "DonationRequests",
                columns: new[] { "BloodType", "Urgency", "ExpiryDate" },
                filter: "\"Status\" = 'Active'");

            migrationBuilder.CreateIndex(
                name: "ix_donationacceptances_pending_timeout",
                table: "DonationAcceptances",
                column: "AcceptedAt",
                filter: "\"Status\" = 'Accepted'");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_outboxmessages_unprocessed",
                table: "OutboxMessages");

            migrationBuilder.DropIndex(
                name: "IX_IdempotentRequests_CreatedOn",
                table: "IdempotentRequests");

            migrationBuilder.DropIndex(
                name: "ix_donationrequests_active_feed",
                table: "DonationRequests");

            migrationBuilder.DropIndex(
                name: "ix_donationacceptances_pending_timeout",
                table: "DonationAcceptances");

            migrationBuilder.CreateIndex(
                name: "IX_OutboxMessages_CreatedOn",
                table: "OutboxMessages",
                column: "CreatedOn");

            migrationBuilder.CreateIndex(
                name: "IX_DonationRequests_Status_BloodType",
                table: "DonationRequests",
                columns: new[] { "Status", "BloodType" });

            migrationBuilder.CreateIndex(
                name: "IX_DonationAcceptances_Status_AcceptedAt",
                table: "DonationAcceptances",
                columns: new[] { "Status", "AcceptedAt" });
        }
    }
}
