using glovo_webapi.Models;
using glovo_webapi.Models.Restaurant;
using Microsoft.EntityFrameworkCore;

namespace glovo_webapi.Data
{
    public class GlovoDbContext : DbContext
    {
        public GlovoDbContext(DbContextOptions<GlovoDbContext> opt) : base(opt)
        {
            
        }
        
        public DbSet<Restaurant> Restaurants { get; set; }
    }
}