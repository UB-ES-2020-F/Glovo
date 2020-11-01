using Microsoft.EntityFrameworkCore.Migrations;

namespace glovo_webapi.Migrations
{
    public partial class MigrationProductsOfRestaurant : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "IdRest",
                table: "Products",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IdRest",
                table: "Products");
        }
    }
}
