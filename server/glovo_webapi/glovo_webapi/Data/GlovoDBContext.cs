using glovo_webapi.Entities;
using Microsoft.EntityFrameworkCore;

namespace glovo_webapi.Data
{
    public class GlovoDbContext : DbContext
    {
        public GlovoDbContext(DbContextOptions<GlovoDbContext> opt) : base(opt)
        {
            
        }
        
        public DbSet<Restaurant> Restaurants { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Product> Products { get; set; }
    }
}
