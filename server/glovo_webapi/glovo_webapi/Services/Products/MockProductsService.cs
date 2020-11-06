using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.Products
{
    public class MockProductsService : IProductsService
    {
        private Restaurant rest1;
        private Restaurant rest2;
        private Restaurant rest3;

        public MockProductsService()
        {
            rest1 = new Restaurant(0, "Restaurant 1", "");
            rest2 = new Restaurant(1, "Restaurant 2", "");
            rest3 = new Restaurant(2, "Restaurant 3", "");
        }
        public IEnumerable<Product> GetAllProducts()
        {
            return new List<Product>
            {
                new Product(1, "Hambur Guesa Bacon", "img/products/hambur1.jpg", "This hamburger will prevent YOU to starve", 3.14f, 0),
                new Product(2, "Hambur Guesa Lechuga", "img/products/hambur2.jpg", "This hamburger will prevent YOU to starve", 4.24f, 0),
                new Product(3, "Hambur Guesa Pescado", "img/products/hambur3.jpg", "This hamburger will prevent YOU to starve", 5.44f, 1),
                new Product(4, "Hambur Guesa Marisco", "img/products/hambur4.jpg", "This hamburger will prevent YOU to starve", 6.84f, 1),
                new Product(5, "Hambur Guesa Guesa", "img/products/hambur5.jpg", "This hamburger will prevent YOU to starve", 8.64f, 2)
            };
        }

        public Product GetProductById(int id)
        {
            return new Product(id, "Hambur Guesa", "img/products/hambur.jpg", "This hamburger will prevent YOU to starve", 3.14f, 0);
        }

        public IEnumerable<Product> GetAllProductsOfRestaurant(int idRest)
        {
            return new List<Product>
            {
                new Product(1, "Hambur Guesa Bacon", "img/products/hambur1.jpg", "This hamburger will prevent YOU to starve", 3.14f, idRest),
                new Product(2, "Hambur Guesa Lechuga", "img/products/hambur2.jpg", "This hamburger will prevent YOU to starve", 4.24f, idRest),
                new Product(3, "Hambur Guesa Pescado", "img/products/hambur3.jpg", "This hamburger will prevent YOU to starve", 5.44f, idRest),
                new Product(4, "Hambur Guesa Marisco", "img/products/hambur4.jpg", "This hamburger will prevent YOU to starve", 6.84f, idRest),
                new Product(5, "Hambur Guesa Guesa", "img/products/hambur5.jpg", "This hamburger will prevent YOU to starve", 8.64f, idRest)
            };
        }

        public Product GetProductOfRestaurantById(int idRest, int idProd)
        {
            return new Product(idProd, "Hambur Guesa Bacon", "img/products/hambur1.jpg",
                "This hamburger will prevent YOU to starve", 3.14f, idRest);
        }
    }
}