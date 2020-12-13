using System;
using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Controllers.Orders;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;
using glovo_webapi.Profiles;
using glovo_webapi.Services.Orders;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace glovo_webapi_test.ControllersTests.Orders
{
    public class OrdersOfRestaurantTest
    {
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public OrdersOfRestaurantTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestOrdersOfRestaurant.db")
                .Options;
            
            SeedDatabase();
        }

        private RestApiOrdersService _ordersService;
        
        private List<Product> _products;
        private List<Restaurant> _restaurants;
        private List<User> _users;
        private List<Order> _orders;
        private List<OrderProduct> _orderProducts;

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
                new Product("name-p1", "imgPath-p1", "desc-p1", 10, 1, "Menu") {Id = 1},
                new Product("name-p2", "imgPath-p2", "desc-p2", 20, 2, "Menu") {Id = 2},
                new Product("name-p3", "imgPath-p3", "desc-p3", 5, 2, "Menu") {Id = 3},
                new Product("name-p4", "imgPath-p4", "desc-p4", 15, 2, "Menu") {Id = 4},
                new Product("name-p5", "imgPath-p5", "desc-p5", 12, 2, "Menu") {Id = 5}
            };
            _users = new List<User>()
            {
                new User("u1", "u1@komet.net", "password-u1", new Location(0, 0), UserRole.Regular) {Id = 1},
                new User("u2", "u2@komet.net", "password-u2", new Location(0, 0), UserRole.Regular) {Id = 2},
                new User("a1", "a1@komet.net", "password-a1", new Location(0, 0), UserRole.Administrator) {Id = 3}
            };
            _orders = new List<Order>()
            {
                new Order(DateTime.Parse("2020-01-01 12:00:00"), 1, 1) {Id = 1},
                new Order(DateTime.Parse("2020-01-02 12:00:00"), 1, 2) {Id = 2},
                new Order(DateTime.Parse("2020-01-03 12:00:00"), 2, 2) {Id = 3}
            };
            _orderProducts = new List<OrderProduct>()
            {
                new OrderProduct(1, 1, 5),
                new OrderProduct(2, 2, 5),
                new OrderProduct(3, 2, 2),
                new OrderProduct(3, 3, 3),
                new OrderProduct(3, 4, 4),
                new OrderProduct(3, 5, 5)
            };
            
            context.AddRange(_restaurants);
            context.SaveChanges();
            context.AddRange(_products);
            context.SaveChanges();
            context.AddRange(_users);
            context.SaveChanges();
            context.AddRange(_orders);
            context.SaveChanges();
            context.AddRange(_orderProducts);
            context.SaveChanges();
        }
        
        private OrdersOfRestaurantController CreateFakeOrdersOfRestaurantController(User loggedUser = null)
        {
            //Create fake DBContext
            var context = new GlovoDbContext(ContextOptions);

            //Create fake HttpContextAccessor
            var httpContext = new DefaultHttpContext();
            var httpContextAccessor = new HttpContextAccessor {
                HttpContext = httpContext
            };

            //Add logged user to HttpContextAccessor in case it is needed
            if (loggedUser != null)
                httpContextAccessor.HttpContext.Items["User"] = loggedUser;
            
            //Create RestApiRestaurantsService instance with fake DBContext and HttpContextAccessor
            _ordersService = new RestApiOrdersService(context, httpContextAccessor);
            
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
            var ordersController = new OrdersOfRestaurantController(_ordersService, mapper) {
                ControllerContext = {HttpContext = httpContext}
            };

            return ordersController;
        }

        [Fact]
        public void GetOrdersOfRestaurantTest()
        {
            OrdersOfRestaurantController ordersController = CreateFakeOrdersOfRestaurantController();
            
            //Retrieving all orders of existing restaurant
            var response = ordersController.GetAllOrdersOfRestaurant(_restaurants[0].Id);
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_orders.FindAll(o => o.RestaurantId == _restaurants[0].Id).Count, ((IEnumerable<GetOrderModel>)((OkObjectResult)response.Result).Value).Count());
            
            //Retrieving all orders of non-existing restaurant
            response = ordersController.GetAllOrdersOfRestaurant(0);
            Assert.IsType<NotFoundObjectResult>(response.Result);
        }
    }
}