using Microsoft.EntityFrameworkCore.Migrations;

namespace glovo_webapi.Migrations
{
    public partial class CategoryRefactor : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Category",
                table: "Products",
                type: "character varying(127)",
                maxLength: 127,
                nullable: true,
                oldClrType: typeof(int),
                oldType: "integer");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "Category",
                table: "Products",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(string),
                oldType: "character varying(127)",
                oldMaxLength: 127,
                oldNullable: true);
        }
    }
}
