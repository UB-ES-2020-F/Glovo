using System;
using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Controllers.Orders;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;
using glovo_webapi.Models.OrderProduct;
using glovo_webapi.Profiles;
using glovo_webapi.Services.Orders;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace glovo_webapi_test.ControllersTests.Orders
{
    public class OrdersControllerTest
    {    
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public OrdersControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestOrders.db")
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
        
        private OrdersController CreateFakeOrdersController(User loggedUser = null)
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
            var ordersController = new OrdersController(_ordersService, mapper) {
                ControllerContext = {HttpContext = httpContext}
            };

            return ordersController;
        }
        
        [Fact]
        private void GetAllOrdersTest()
        {
            OrdersController ordersController = CreateFakeOrdersController(_users[2]);
            
            //Retrieving all orders
            var response = ordersController.GetAllOrders();
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_orders.Count, ((IEnumerable<GetOrderModel>)((OkObjectResult)response.Result).Value).Count());
        }

        [Fact]
        private void GetOrderByIdTest()
        {
            OrdersController ordersController = CreateFakeOrdersController(_users[2]);
            
            //Retrieving existing order
            var response = ordersController.GetOrderById(_users[0].Id);
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_users[0].Id, ((GetOrderModel)((OkObjectResult)response.Result).Value).Id);
            
            //Retrieving non-existing order
            response = ordersController.GetOrderById(0);
            Assert.IsType<NotFoundObjectResult>(response.Result);
            
            ordersController = CreateFakeOrdersController(_users[0]);
            
            //Retrieving different user order (regular)
            response = ordersController.GetOrderById(_orders[2].Id);
            Assert.IsType<UnauthorizedObjectResult>(response.Result);
        }

        [Fact]
        private void PostValidOrderTest()
        {
            OrdersController ordersController = CreateFakeOrdersController(_users[0]);
            PostOrderModel postOrderModel = new PostOrderModel(2, new List<OrderProductModel>() {
                new OrderProductModel(2, 1),
                new OrderProductModel(3, 10),
                new OrderProductModel(4, 100)
            });
            
            //Add valid order
            var response = ordersController.PostOrder(postOrderModel);
            Assert.IsType<OkObjectResult>(response.Result);

            //Check same order is posted
            GetOrderModel getOrderModel = ((GetOrderModel) ((OkObjectResult) response.Result).Value);
            Order postedOrder = _ordersService.GetOrderById(getOrderModel.Id);
            Assert.Equal(getOrderModel.Id, postedOrder.Id);
            Assert.Equal(postOrderModel.RestaurantId, postedOrder.RestaurantId);
            
            var orderProductPairs = postedOrder.OrdersProducts.Zip(postOrderModel.Products, (op1, op2) => new { poOrderProduct = op1, opmOrderProduct = op2 });
            foreach(var orderProductPair in orderProductPairs)
            {
                Assert.Equal(orderProductPair.poOrderProduct.ProductId, orderProductPair.opmOrderProduct.ProductId);
                Assert.Equal(orderProductPair.poOrderProduct.Quantity, orderProductPair.opmOrderProduct.Quantity);
            }
        }
        
        [Fact]
        private void PostInvalidOrderTest()
        {
            OrdersController ordersController = CreateFakeOrdersController(_users[0]);
            PostOrderModel postOrderModel = new PostOrderModel(2, new List<OrderProductModel>() {
                new OrderProductModel(2, 1)
            });
            
            //Add order with nonexistent restaurant id
            postOrderModel.RestaurantId = 0;
            var response = ordersController.PostOrder(postOrderModel);
            Assert.IsType<NotFoundObjectResult>(response.Result);
            postOrderModel.RestaurantId = 2;
            
            //Add order with nonexistant product id
            postOrderModel.Products = new List<OrderProductModel> {
                new OrderProductModel(0, 1)
            };
            response = ordersController.PostOrder(postOrderModel);
            Assert.IsType<NotFoundObjectResult>(response.Result);
            postOrderModel.Products = new List<OrderProductModel> {
                new OrderProductModel(2, 1)
            };
            
            //Add order with product not belonging to restaurant
            postOrderModel.Products = new List<OrderProductModel> {
                new OrderProductModel(1, 1)
            };
            response = ordersController.PostOrder(postOrderModel);
            Assert.IsType<BadRequestObjectResult>(response.Result);
            postOrderModel.Products = new List<OrderProductModel> {
                new OrderProductModel(2, 1)
            };
        }
    }
}