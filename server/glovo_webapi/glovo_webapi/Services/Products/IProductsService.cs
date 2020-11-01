using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.Products
{
    public interface IProductsService
    {
        IEnumerable<Product> GetAllProducts();
        Product GetProductById(int id);
        IEnumerable<Product> GetAllProductsOfRestaurant(int idRest);
        Product GetProductOfRestaurantById(int idRest, int idProd);
    }
}