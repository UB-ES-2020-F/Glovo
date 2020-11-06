using System.Collections.Generic;
using glovo_webapi.Entities;
using glovo_webapi.Utils;

namespace glovo_webapi.Services.Products
{
    public interface IProductsService
    {
        IEnumerable<Product> GetAllProducts();
        IEnumerable<Product> GetProductsByCategory(ProductCategory c);
        Product GetProductById(int id);
        IEnumerable<Product> GetAllProductsOfRestaurant(int idRest);
        IEnumerable<Product> GetAllProductsOfRestaurantByCategory(int idRest, ProductCategory c);
        Product GetProductOfRestaurantById(int idRest, int idProd);
    }
}