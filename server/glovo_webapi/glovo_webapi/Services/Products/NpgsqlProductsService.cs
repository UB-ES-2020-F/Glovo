using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Utils;

namespace  glovo_webapi.Services.Products
{
    public class NpgsqlProductsService : IProductsService
    {
        private readonly GlovoDbContext _context;

        public NpgsqlProductsService(GlovoDbContext context)
        {
            _context = context;
        }
        
        public IEnumerable<Product> GetAllProducts()
        {
            return _context.Products.ToList();
        }

        public IEnumerable<Product> GetProductsByCategory(ProductCategory c)
        {
            if (c == ProductCategory.Uncategorized)
            {
                return _context.Products.ToList();
            }
            return _context.Products.Where(p => p.Category == c);
        }

        public Product GetProductById(int id)
        {
            return _context.Products.FirstOrDefault(p => p.Id == id);
        }

        public IEnumerable<Product> GetAllProductsOfRestaurant(int idRest)
        {
            Restaurant r = _context.Restaurants.SingleOrDefault(p => p.Id == idRest);
            if (r == null)
            {
                return null;
            }
            return r.Product;
        }

        public IEnumerable<Product> GetAllProductsOfRestaurantByCategory(int idRest, ProductCategory c)
        {
            Restaurant r = _context.Restaurants.SingleOrDefault(p => p.Id == idRest);
            if (r == null)
            {
                return null;
            }
            if (c == ProductCategory.Uncategorized)
            {
                return r.Product.ToList();
            }
            return r.Product.Where(p => p.Category == c);
        }

        public Product GetProductOfRestaurantById(int idRest, int idProd)
        {
            return _context.Products.Where(p => p.RestaurantId == idRest).FirstOrDefault(p => p.Id == idProd);
        }
    }
}