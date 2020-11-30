using glovo_webapi.Entities;
using Microsoft.EntityFrameworkCore;

namespace glovo_webapi.Data
{
    public class GlovoDbContext : DbContext
    {
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<OrderProduct>()
                .HasKey(o => new {o.OrderId, o.ProductId});
        }
        
        public GlovoDbContext(DbContextOptions<GlovoDbContext> opt) : base(opt) { }
        public DbSet<Restaurant> Restaurants { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderProduct> OrdersProducts { get; set; }
    }
}
