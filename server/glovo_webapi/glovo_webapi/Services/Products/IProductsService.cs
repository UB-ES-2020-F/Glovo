using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.Products
{
    public interface IProductsService
    {
        IEnumerable<Product> GetAllProducts();
        Product GetProductById(int id);
    }
}