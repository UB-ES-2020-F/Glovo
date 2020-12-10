using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AutoMapper;
using glovo_webapi.Controllers.Users;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Models.Users;
using glovo_webapi.Profiles;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Xunit;

namespace glovo_webapi_test.ControllersTests.Users
{
    public class UserAccountControllerTest
    {
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public UserAccountControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestUserAccount.db")
                .Options;
            
            SeedDatabase();
        }

        private static readonly Random Random = new Random();

        private string RandomString(int length)
        {
            const string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[Random.Next(s.Length)]).ToArray());
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
        
        private string _testApiSecret;
        
        private UserAccountController CreateFakeUserAccountController(User loggedUser = null)
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

            //Create AppConfiguration options using fake secret string
            _testApiSecret = RandomString(1024);
            IOptions<AppConfiguration> appConfigOptions = new OptionsWrapper<AppConfiguration>(
                new AppConfiguration {Secret = _testApiSecret}
                );
            
            //Create UsersController instance with the RestApiUsersService instance, the mapper and the
            //fake AppConfiguration
            var usersController = new UserAccountController(_usersService, mapper, appConfigOptions) {
                ControllerContext = {HttpContext = httpContext}
            };

            return usersController;
        }

        [Fact]
        public void AuthenticateValidCredentialsTest()
        {
            UserAccountController userController = CreateFakeUserAccountController();

            //Authenticate with valid credentials
            var response = userController.Authenticate(
                new ReceiveLoginUserModel(_users[0].Email, "password-u1")
            );
            Assert.IsType<OkObjectResult>(response.Result);

            //Validate return data from endpoint
            SendLoginUserModel sendLoginUserModel =
                (SendLoginUserModel) ((OkObjectResult) response.Result).Value;
            Assert.Equal(_users[0].Id, sendLoginUserModel.Id);
            Assert.Equal(_users[0].Email, sendLoginUserModel.Email);

            TokenCreatorValidator tokenCreatorValidator = new TokenCreatorValidator(_testApiSecret);
            TokenValidationParams tokenValidationParams = tokenCreatorValidator.ValidateToken(sendLoginUserModel.Token);
            Assert.Equal(_users[0].Id, tokenValidationParams.UserId);

            User authenticatedUser = _usersService.GetById(_users[0].Id);
            Assert.Equal(
                Encoding.Default.GetString(authenticatedUser.AuthSalt),
                Encoding.Default.GetString(tokenValidationParams.SaltBytes)
            );
        }

        [Fact]
        public void AuthenticateInvalidCredentialsTest()
        {
            UserAccountController userController = CreateFakeUserAccountController();
            
            //Authenticate with invalid credentials
            var response = userController.Authenticate(
                new ReceiveLoginUserModel(_users[0].Email, "wrong-password")
            );
            Assert.IsType<BadRequestObjectResult>(response.Result);
            
            response = userController.Authenticate(
                new ReceiveLoginUserModel("wrong-email", "password-u1")
            );
            Assert.IsType<BadRequestObjectResult>(response.Result);
        }

        [Fact]
        public void RegisterTest()
        {
            UserAccountController userController = CreateFakeUserAccountController();
            
            //Register user correctly
            var response = userController.Register(new RegisterUserModel(
                "reg-user-name", "reg-user-email", "reg-user-password"
                ));
            Assert.IsType<OkResult>(response);
            
            User registeredUser = _usersService.GetByEmail("reg-user-email");
            Assert.Equal("reg-user-name", registeredUser.Name);
            Assert.Equal("reg-user-email", registeredUser.Email);
            Assert.True(PasswordVerifier.VerifyPasswordHash("reg-user-password", registeredUser.PasswordHash, registeredUser.PasswordSalt));
        }

        [Fact]
        public void LogoutTest()
        {
            UserAccountController userController = CreateFakeUserAccountController(_users[0]);

            //Load auth salt with some bytes and check null after logout
            _users[0].AuthSalt = new Byte[] {88};
            Assert.NotNull(_users[0].AuthSalt);

            var response = userController.Logout();
            Assert.IsType<OkResult>(response);
            Assert.Null(_users[0].AuthSalt);
        }
    }
}