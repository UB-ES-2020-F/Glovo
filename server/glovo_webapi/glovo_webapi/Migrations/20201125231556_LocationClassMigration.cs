using Microsoft.EntityFrameworkCore.Migrations;

namespace glovo_webapi.Migrations
{
    public partial class LocationClassMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "LocationLong",
                table: "Users",
                newName: "Location_Longitude");

            migrationBuilder.RenameColumn(
                name: "LocationLat",
                table: "Users",
                newName: "Location_Latitude");

            migrationBuilder.RenameColumn(
                name: "LocationLong",
                table: "Restaurants",
                newName: "Location_Longitude");

            migrationBuilder.RenameColumn(
                name: "LocationLat",
                table: "Restaurants",
                newName: "Location_Latitude");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Location_Longitude",
                table: "Users",
                newName: "LocationLong");

            migrationBuilder.RenameColumn(
                name: "Location_Latitude",
                table: "Users",
                newName: "LocationLat");

            migrationBuilder.RenameColumn(
                name: "Location_Longitude",
                table: "Restaurants",
                newName: "LocationLong");

            migrationBuilder.RenameColumn(
                name: "Location_Latitude",
                table: "Restaurants",
                newName: "LocationLat");
        }
    }
}
