using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Controllers.Products;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;
using glovo_webapi.Profiles;
using glovo_webapi.Services.Products;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace glovo_webapi_test.ControllersTests.Products
{
    
    public class ProductsOfRestaurantControllerTest
    {    
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public ProductsOfRestaurantControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestProductsOfRestaurant.db")
                .Options;
            
            SeedDatabase();
        }

        private RestApiProductsService _productsService;

        private List<Product> _products;
        private List<Restaurant> _restaurants;
        
        private void SeedDatabase()
        {
            var context = new GlovoDbContext(ContextOptions);
            
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();
            
            _restaurants = new List<Restaurant>()
            {
                new Restaurant("name-r1", "imgPath-u1", new Location(1, 0)) {Id = 1},
                new Restaurant("name-r2", "imgPath-u2", new Location(2, 0)) {Id = 2}
            };
            _products = new List<Product>()
            {
                new Product("name-p1", "imgPath-p1", "desc-p1", 10, 1, ProductCategory.C1) {Id = 1},
                new Product("name-p2", "imgPath-p2", "desc-p2", 20, 2, ProductCategory.C1) {Id = 2},
                new Product("name-p3", "imgPath-p3", "desc-p3", 5, 2, ProductCategory.C1) {Id = 3},
                new Product("name-p4", "imgPath-p4", "desc-p4", 15, 2, ProductCategory.Uncategorized) {Id = 4},
                new Product("name-p5", "imgPath-p5", "desc-p5", 12, 2, ProductCategory.Uncategorized) {Id = 5}
            };
            
            context.AddRange(_restaurants);
            context.SaveChanges();
            context.AddRange(_products);
            context.SaveChanges();
        }
        
        private ProductsOfRestaurantController CreateFakeProductsOfRestaurantController()
        {
            //Create fake DBContext
            var context = new GlovoDbContext(ContextOptions);

            //Create RestApiRestaurantsService instance with fake DBContext
            _productsService = new RestApiProductsService(context);
            
            //Create mapper with UsersProfile
            var mapper = new MapperConfiguration(cfg => {
                cfg.AddProfile<LocationsProfile>();
                cfg.AddProfile<OrdersProductsProfile>();
                cfg.AddProfile<OrdersProfile>();
                cfg.AddProfile<ProductsProfile>();
                cfg.AddProfile<RestaurantsProfile>();
                cfg.AddProfile<UsersProfile>();
            }).CreateMapper();
            
            //Create UsersController instance with the RestApiRestaurantsService instance and the mapper
            var productsController = new ProductsOfRestaurantController(_productsService, mapper);

            return productsController;
        }

        [Fact]
        private void GetAllProductsOfRestaurantTest()
        {
            ProductsOfRestaurantController productsController = CreateFakeProductsOfRestaurantController();
            
            //Retrieving all products of restaurant, no category
            var response = productsController.GetAllProductsOfRestaurant(_restaurants[0].Id, null);
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_products.FindAll(p => p.RestaurantId == _restaurants[0].Id).Count, ((IEnumerable<ProductModel>)((OkObjectResult)response.Result).Value).Count());
        }

        [Fact]
        private void GetAllProductsOfRestaurantOfCategoryTest()
        {
            ProductsOfRestaurantController productsController = CreateFakeProductsOfRestaurantController();
            
            //Retrieving all products of restaurant of first category
            var response = productsController.GetAllProductsOfRestaurant(_restaurants[0].Id, ProductCategory.C1);
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_products.FindAll(p => p.RestaurantId == _restaurants[0].Id && p.Category == ProductCategory.C1).Count, ((IEnumerable<ProductModel>)((OkObjectResult)response.Result).Value).Count());
        }
    }
}