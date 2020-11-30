using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;

namespace  glovo_webapi.Services.Products
{
    public class RestApiProductsService : IProductsService
    {
        private readonly GlovoDbContext _context;

        public RestApiProductsService(GlovoDbContext context)
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
            Product foundProduct = _context.Products.FirstOrDefault(p => p.Id == id);
            if (foundProduct == null)
            {
                throw new RequestException(ProductExceptionCodes.ProductNotFound);
            }

            return foundProduct;
        }

        public IEnumerable<Product> GetAllProductsOfRestaurant(int idRest)
        {
            Restaurant r = _context.Restaurants.SingleOrDefault(p => p.Id == idRest);
            if (r == null)
                throw new RequestException(ProductExceptionCodes.RestaurantNotFound);
            return _context.Products.Where(p => p.RestaurantId == idRest);
        }

        public IEnumerable<Product> GetAllProductsOfRestaurantByCategory(int idRest, ProductCategory c)
        {
            Restaurant r = _context.Restaurants.SingleOrDefault(p => p.Id == idRest);
            if (r == null)
                throw new RequestException(ProductExceptionCodes.RestaurantNotFound);
            if (c == ProductCategory.Uncategorized)
                return _context.Products.Where(p => p.RestaurantId == idRest);
            return _context.Products.Where(p => p.RestaurantId == idRest && p.Category == c);
        }
    }
}