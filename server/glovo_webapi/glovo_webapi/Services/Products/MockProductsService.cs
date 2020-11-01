using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.Products
{
    public class MockProductsService : IProductsService
    {
        public IEnumerable<Product> GetAllProducts()
        {
            return new List<Product>
            {
                new Product(1, "Hambur Guesa Bacon", "img/products/hambur1.jpg", "This hamburger will prevent YOU to starve", 3.14f),
                new Product(2, "Hambur Guesa Lechuga", "img/products/hambur2.jpg", "This hamburger will prevent YOU to starve", 4.24f),
                new Product(3, "Hambur Guesa Pescado", "img/products/hambur3.jpg", "This hamburger will prevent YOU to starve", 5.44f),
                new Product(4, "Hambur Guesa Marisco", "img/products/hambur4.jpg", "This hamburger will prevent YOU to starve", 6.84f),
                new Product(5, "Hambur Guesa Guesa", "img/products/hambur5.jpg", "This hamburger will prevent YOU to starve", 8.64f)
            };
        }

        public Product GetProductById(int id)
        {
            return new Product(0, "Hambur Guesa", "img/products/hambur.jpg", "This hamburger will prevent YOU to starve", 3.14f);
        }
    }
}