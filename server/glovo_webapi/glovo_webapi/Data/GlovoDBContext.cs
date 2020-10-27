using glovo_webapi.Models;
using Microsoft.EntityFrameworkCore;

namespace glovo_webapi.Data
{
    public class GloboDBContext : DbContext
    {
        public GloboDBContext(DbContextOptions<GloboDBContext> opt) : base(opt)
        {
            
        }
        
        public DbSet<Restaurant> Restaurants { get; set; }
    }
}