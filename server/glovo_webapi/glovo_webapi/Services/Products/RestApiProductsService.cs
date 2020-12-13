using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
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

        public List<ProductGroup> GetProductsGroupOfRestaurant(int idRest)
        {
            Restaurant r = _context.Restaurants.SingleOrDefault(p => p.Id == idRest);
            if (r == null)
                throw new RequestException(ProductExceptionCodes.RestaurantNotFound);
            
            var productGroups = new List<ProductGroup>();
            List<string> categories = _context
                .Products
                .Where(p => p.RestaurantId == idRest)
                .Select(p => p.Category)
                .Distinct().ToList();
            foreach (var category in categories)
            {
                ProductGroup cp = new ProductGroup();
                cp.Category = category;
                cp.Products = _context
                    .Products
                    .Where(p => p.RestaurantId == idRest && p.Category == category)
                    .ToList();
                productGroups.Add(cp);
            }

            return productGroups;
        }
    }
}