using Microsoft.EntityFrameworkCore.Migrations;

namespace glovo_webapi.Migrations
{
    public partial class LocationMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "LocationLat",
                table: "Users",
                type: "double precision",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "LocationLong",
                table: "Users",
                type: "double precision",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "LocationLat",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "LocationLong",
                table: "Users");
        }
    }
}
