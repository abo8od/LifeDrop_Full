using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddPerformanceIndexes : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Users_Role",
                table: "Users",
                column: "Role");

            migrationBuilder.CreateIndex(
                name: "IX_PointTransactions_CreatedOn",
                table: "PointTransactions",
                column: "CreatedOn");

            migrationBuilder.CreateIndex(
                name: "IX_Hospitals_IsVerified",
                table: "Hospitals",
                column: "IsVerified");

            migrationBuilder.CreateIndex(
                name: "IX_DonorProfiles_GamificationPoints_ReliabilityScore",
                table: "DonorProfiles",
                columns: new[] { "GamificationPoints", "ReliabilityScore" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Users_Role",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_PointTransactions_CreatedOn",
                table: "PointTransactions");

            migrationBuilder.DropIndex(
                name: "IX_Hospitals_IsVerified",
                table: "Hospitals");

            migrationBuilder.DropIndex(
                name: "IX_DonorProfiles_GamificationPoints_ReliabilityScore",
                table: "DonorProfiles");
        }
    }
}
