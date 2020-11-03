using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using glovo_webapi.Models.Product;
using glovo_webapi.Models.Restaurant;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Xunit;
using Xunit.Abstractions;

namespace glovo_webapi_test.Endpoints
{
    public class ProductsOfRestaurantEndpointsTests
    {
        private readonly ITestOutputHelper _output;
        private HttpClient _client;
        private JsonSerializer _serializer;

        private List<List<ProductReadModel>> mockProducts;
        
        public ProductsOfRestaurantEndpointsTests(ITestOutputHelper output)
        {
            _output = output;
            _client = new HttpClient();
            _serializer = new JsonSerializer();
            
            mockProducts = new List<List<ProductReadModel>>
                {
                    new List<ProductReadModel>
                    {
                        new ProductReadModel(1, "Chicken bucket", "img/chicken_bucket.jpg", "Delicioso cubo de pollo, contiene 16 piezas", 14.00f, 1),
                        new ProductReadModel(2, "Chicken bucket XXL", "img/chicken_bucket_2.jpg", "Deliciosisimo cubo de pollo, contiene 40 piezas", 30.00f, 1),
                        new ProductReadModel(3, "Chicken bucket XXXXL", "img/chicken_bucket_3.jpg", "Delissssssssiooooosssssso cubo de pollo, contiene 99 piezas", 65.00f, 1),
                    },
                    new List<ProductReadModel>
                    {
                        new ProductReadModel(4, "Patatas S", "img/french_fries_1.jpg", "2 patatas fritas rancias", 2.99f, 2),
                        new ProductReadModel(5, "Patatas M", "img/french_fries_2.jpg", "3 patatas fritas rancias", 3.99f, 2),
                        new ProductReadModel(6, "Patatas L", "img/french_fries_3.jpg", "3 patatas fritas no rancias", 4.99f, 2),

                    },
                    new List<ProductReadModel>
                    {
                        new ProductReadModel(7, "Hambur Guesa", "img/burger1.jpg", "This hamburger will prevent you from starving", 7.95f, 3),
                        new ProductReadModel(8, "Hambur Guesa Guesa", "img/burger2.jpg", "This hamburger will prevent you from starving for two days", 7.96f, 3),
                        new ProductReadModel(9, "Hambur Goza", "img/burger3.jpg", "This hamburger will prevent you from starving for one week", 8.95f, 3),

                    },
                    new List<ProductReadModel>
                    {
                        new ProductReadModel(10, "Kangreburger", "img/kkburger.jpg", "Delicious krab burger", 1.00f, 4),
                        new ProductReadModel(11, "Kangrefries", "img/kkfries.jpg", "Delicious krab fries", 1.00f, 4),
                        new ProductReadModel(12, "Kangrecola", "img/kkcola.jpg", "Delicious krab cola", 1.00f, 4)
                    },
                };
        }
        
        [Fact]
        public void GetAllProductsOfAllRestaurantsTest()
        {
            //Query mock products by Id of Restaurant from DB
            for (int idRest = 1; idRest <= 4; idRest++)
            {
                string endpointUrl = "https://localhost:5001/api/restaurants/" + idRest.ToString() + "/products";
                HttpResponseMessage response = _client.GetAsync(endpointUrl).Result;
                string responseBodyStr = response.Content.ReadAsStringAsync().Result;
                List<ProductReadModel> queriedProducts = (List<ProductReadModel>) _serializer.Deserialize<IEnumerable<ProductReadModel>>(new JsonTextReader(new StringReader(responseBodyStr)));

                //Check if queried and expected products are the same
                queriedProducts.Sort((r1, r2) => r1.Id - r2.Id);
                var products = mockProducts[idRest-1].Zip(queriedProducts, (mockProduct, queriedProduct) => new { Expected = mockProduct, Queried = queriedProduct });
                foreach(var productPair in products)
                {
                    Assert.Equal(productPair.Expected.Id, productPair.Queried.Id);
                    Assert.Equal(productPair.Expected.Name, productPair.Queried.Name);
                    Assert.Equal(productPair.Expected.ImgPath, productPair.Queried.ImgPath);
                    Assert.Equal(productPair.Expected.Description, productPair.Queried.Description);
                    Assert.Equal(productPair.Expected.Price, productPair.Queried.Price);
                    Assert.Equal(productPair.Expected.IdRest, productPair.Queried.IdRest);
                }
            }
        }
        
        [Fact]
        public void GetProductOfRestaurantByIdTest()
        {
            //Query mock products by Id from DB
            for (int idProd = 1; idProd <= 12; idProd++)
            {
                int idRest = (idProd-1) / 3 + 1;
                string endpointUrl = "https://localhost:5001/api/restaurants/" + idRest.ToString() + "/products/" +
                                     idProd.ToString();
                HttpResponseMessage response = _client.GetAsync(endpointUrl).Result;
                string responseBodyStr = response.Content.ReadAsStringAsync().Result;
                ProductReadModel queriedProduct = (ProductReadModel) _serializer.Deserialize<ProductReadModel>(new JsonTextReader(new StringReader(responseBodyStr)));

                //Check if queried and expected products are the same
                Assert.Equal(mockProducts[idRest-1][(idProd-1)%3].Id, queriedProduct.Id);
                Assert.Equal(mockProducts[idRest-1][(idProd-1)%3].Name, queriedProduct.Name);
                Assert.Equal(mockProducts[idRest-1][(idProd-1)%3].ImgPath, queriedProduct.ImgPath);
                Assert.Equal(mockProducts[idRest-1][(idProd-1)%3].Description, queriedProduct.Description);
                Assert.Equal(mockProducts[idRest-1][(idProd-1)%3].Price, queriedProduct.Price);
                Assert.Equal(mockProducts[idRest-1][(idProd-1)%3].IdRest, queriedProduct.IdRest);
            }
        }
        
        [Fact]
        public void GetAllProductsOfRestaurantNotFoundTest()
        {
            //Query inexistent products from DB
            string endpointUrl = "https://localhost:5001/api/restaurants/9999/products";
            HttpResponseMessage response = _client.GetAsync(endpointUrl).Result;
            Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        }
        
        [Fact]
        public void GetProductOfRestaurantByIdNotFoundTest1()
        {
            //Query inexistent products from DB
            string endpointUrl = "https://localhost:5001/api/restaurants/9999/products/1";
            HttpResponseMessage response = _client.GetAsync(endpointUrl).Result;
            Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        }

        [Fact]
        public void GetProductOfRestaurantByIdNotFoundTest2()
        {
            //Query inexistent products from DB
            string endpointUrl = "https://localhost:5001/api/restaurants/1/products/9999";
            HttpResponseMessage response = _client.GetAsync(endpointUrl).Result;
            Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        }
    }
}