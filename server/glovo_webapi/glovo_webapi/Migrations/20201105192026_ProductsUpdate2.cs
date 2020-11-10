using Microsoft.EntityFrameworkCore.Migrations;

namespace glovo_webapi.Migrations
{
    public partial class ProductsUpdate2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Restaurants_RestId",
                table: "Products");

            migrationBuilder.RenameColumn(
                name: "RestId",
                table: "Products",
                newName: "RestaurantId");

            migrationBuilder.RenameIndex(
                name: "IX_Products_RestId",
                table: "Products",
                newName: "IX_Products_RestaurantId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Restaurants_RestaurantId",
                table: "Products",
                column: "RestaurantId",
                principalTable: "Restaurants",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Restaurants_RestaurantId",
                table: "Products");

            migrationBuilder.RenameColumn(
                name: "RestaurantId",
                table: "Products",
                newName: "RestId");

            migrationBuilder.RenameIndex(
                name: "IX_Products_RestaurantId",
                table: "Products",
                newName: "IX_Products_RestId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Restaurants_RestId",
                table: "Products",
                column: "RestId",
                principalTable: "Restaurants",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
