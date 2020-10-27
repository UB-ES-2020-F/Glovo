using glovo_webapi.Models;
using Microsoft.EntityFrameworkCore;
namespace glovo_webapi.Data
{
    public class RestaurantContext : DbContext
    {
        public RestaurantContext(DbContextOptions<RestaurantContext> opt) : base(opt)
        {
            
        }
        
        public DbSet<Restaurant> Restaurants { get; set; }
    }
}