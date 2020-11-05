using Microsoft.EntityFrameworkCore.Migrations;

namespace glovo_webapi.Migrations
{
    public partial class ProductsUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "IdRest",
                table: "Products",
                newName: "RestId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_RestId",
                table: "Products",
                column: "RestId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Restaurants_RestId",
                table: "Products",
                column: "RestId",
                principalTable: "Restaurants",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Restaurants_RestId",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_RestId",
                table: "Products");

            migrationBuilder.RenameColumn(
                name: "RestId",
                table: "Products",
                newName: "IdRest");
        }
    }
}
