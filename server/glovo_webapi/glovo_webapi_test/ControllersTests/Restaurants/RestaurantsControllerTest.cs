using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Controllers.Restaurants;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Models.Location;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Profiles;
using glovo_webapi.Services.Restaurants;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace glovo_webapi_test.ControllersTests.Restaurants
{
    
    public class RestaurantsControllerTest
    {    
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public RestaurantsControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestRestaurants.db")
                .Options;
            
            SeedDatabase();
        }

        private RestApiRestaurantsService _restaurantsService;

        private List<Restaurant> _restaurants;
        
        private void SeedDatabase()
        {
            var context = new GlovoDbContext(ContextOptions);
            
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();
            
            _restaurants = new List<Restaurant>()
            {
                new Restaurant("name-r1", "imgPath-u1", new Location(1, 0)) {Id = 1},
                new Restaurant("name-r2", "imgPath-u2", new Location(2, 0)) {Id = 2},
                new Restaurant("name-r3", "imgPath-u3", new Location(3, 0)) {Id = 3},
                new Restaurant("name-r4", "imgPath-u4", new Location(4, 0)) {Id = 4},
                new Restaurant("name-r5", "imgPath-u5", new Location(5, 0)) {Id = 5}
            };
            
            context.AddRange(_restaurants);
            context.SaveChanges();
        }
        
        private RestaurantsController CreateFakeRestaurantsController()
        {
            //Create fake DBContext
            var context = new GlovoDbContext(ContextOptions);

            //Create RestApiRestaurantsService instance with fake DBContext
            _restaurantsService = new RestApiRestaurantsService(context);
            
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
            var restaurantsController = new RestaurantsController(_restaurantsService, mapper);

            return restaurantsController;
        }

        [Fact]
        private void GetAllRestaurantsTest()
        {
            RestaurantsController restaurantsController = CreateFakeRestaurantsController();
            
            //Retrieving all restaurants
            var response = restaurantsController.GetAllRestaurants();
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_restaurants.Count, ((IEnumerable<LocationRestaurantModel>)((OkObjectResult)response.Result).Value).Count());
        }

        [Fact]
        private void GetRestaurantByIdTest()
        {
            RestaurantsController restaurantsController = CreateFakeRestaurantsController();
            
            //Retrieving existing restaurant
            var response = restaurantsController.GetRestaurantById(_restaurants[0].Id);
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_restaurants[0].Id, ((LocationRestaurantModel)((OkObjectResult)response.Result).Value).Id);
            
            //Retrieving non-existing restaurant
            response = restaurantsController.GetRestaurantById(0);
            Assert.IsType<NotFoundObjectResult>(response.Result);
        }

        [Fact]
        private void GetClosestRestaurantsByIdTest()
        {
            RestaurantsController restaurantsController = CreateFakeRestaurantsController();

            //Retrieve closest restaurants ordered
            var response = restaurantsController.GetClosestRestaurants(new LocationModel{Latitude = 6, Longitude = 0});
            Assert.IsType<OkObjectResult>(response.Result);
            var distanceRestaurantModels =
                (List<DistanceRestaurantModel>) ((OkObjectResult) response.Result).Value;

            for (int i = 0; i < 5; i++)
            {
                Assert.Equal(5-i, distanceRestaurantModels[i].Id);
            }
        }
    }
}