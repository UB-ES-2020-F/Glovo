using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Controllers.Users;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Models.Location;
using glovo_webapi.Profiles;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace glovo_webapi_test.ControllersTests.Users
{
    public class UserLocationControllerTest
    {
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public UserLocationControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestUserLocation.db")
                .Options;
            
            SeedDatabase();
        }

        private RestApiUsersService _usersService;
        private List<User> _users;
        
        private void SeedDatabase()
        {
            var context = new GlovoDbContext(ContextOptions);
            
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();

            _users = new List<User>()
            {
                new User("u1", "u1@komet.net", "password-u1", new Location(0, 0), UserRole.Regular) {Id = 1},
                new User("u2", "u2@komet.net", "password-u2", new Location(0, 0), UserRole.Regular) {Id = 2},
                new User("a1", "a1@komet.net", "password-a1", new Location(0, 0), UserRole.Administrator) {Id = 3}
            };
            
            context.AddRange(_users);
            context.SaveChanges();
        }
        
        private UserLocationController CreateFakeUserLocationController(User loggedUser = null)
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

            //Create RestApiUsersService instance with fake DBContext and HttpContextAccessor
            _usersService = new RestApiUsersService(context, httpContextAccessor);
            
            //Create mapper with UsersProfile
            var mapper = new MapperConfiguration(cfg => {
                cfg.AddProfile<LocationsProfile>();
                cfg.AddProfile<OrdersProductsProfile>();
                cfg.AddProfile<OrdersProfile>();
                cfg.AddProfile<ProductsProfile>();
                cfg.AddProfile<RestaurantsProfile>();
                cfg.AddProfile<UsersProfile>();
            }).CreateMapper();
            
            //Create UsersController instance with the RestApiUsersService instance and the mapper
            var usersController = new UserLocationController(_usersService, mapper) {
                ControllerContext = {HttpContext = httpContext}
            };

            return usersController;
        }
        
        [Fact]
        public void GetLoggedUserLocation()
        {
            UserLocationController usersController = CreateFakeUserLocationController(_users[0]);
            
            //Retrieving logged user location
            var response = usersController.GetUserLocation();
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_users[0].Location.Latitude, ((LocationModel)((OkObjectResult)response.Result).Value).Latitude);
            Assert.Equal(_users[0].Location.Longitude, ((LocationModel)((OkObjectResult)response.Result).Value).Longitude);
        }
        
        [Fact]
        public void SetLoggedUserLocation()
        {
            UserLocationController usersController = CreateFakeUserLocationController(_users[0]);
            
            //Setting logged user location
            var response = usersController.PostUserLocation(new LocationModel(10, 10));
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_users[0].Location.Latitude, ((LocationModel)((OkObjectResult)response.Result).Value).Latitude);
            Assert.Equal(_users[0].Location.Longitude, ((LocationModel)((OkObjectResult)response.Result).Value).Longitude);
        }
    }
}