using System;
using System.Collections.Generic;
using System.Linq;
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
    public class UserAccountRecoveryControllerTest
    {
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public UserAccountRecoveryControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=TestUserAccountRecovery.db")
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
        
        private UserAccountRecoveryController CreateFakeUserAccountRecoveryController(User loggedUser = null)
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
            var usersController = new UserAccountRecoveryController(_usersService, mapper, appConfigOptions) {
                ControllerContext = {HttpContext = httpContext}
            };

            return usersController;
        }

        [Fact]
        public void AskForRecoveryEmailTest()
        {
            UserAccountRecoveryController usersController = CreateFakeUserAccountRecoveryController();
            
            //Check endpoint returns Ok with existing email
            var response = usersController.SendPasswordEmail(
                new PasswordEmailModel(_users[0].Email)
                );
            Assert.IsType<OkObjectResult>(response.Result);
            Assert.Equal(_users[0].Email, ((PasswordEmailModel)((OkObjectResult)response.Result).Value).Email);
            
            //Cannot validate salt, as the token is sent to the user through email and not API
            User emailUser = _usersService.GetById(_users[0].Id);
            Assert.NotNull(emailUser.RecoverySalt);

            //Check endpoint returns error with non-existing email
            response = usersController.SendPasswordEmail(new PasswordEmailModel("non-existing-email"));
            Assert.IsType<BadRequestObjectResult>(response.Result);
        }
        
        [Fact]
        public void ResetPasswordTest()
        {
            UserAccountRecoveryController usersController = CreateFakeUserAccountRecoveryController();
            
            //Set up recovery token on user
            TokenCreatorValidator tokenCreatorValidator = new TokenCreatorValidator(_testApiSecret);
            TokenCreationParams tokenCreationParams = tokenCreatorValidator.CreateToken(_users[0].Id, 30);
            _users[0].RecoverySalt = tokenCreationParams.SaltBytes;
            _usersService.Update(_users[0]);
            
            //Call endpoint with wrong token
            var response = usersController.ResetPassword(new PasswordResetModel(
                _users[0].Email, "wrong-token", "new-password-u1")
            );
            Assert.IsType<BadRequestObjectResult>(response);
            Assert.True(PasswordVerifier.VerifyPasswordHash("password-u1", _users[0].PasswordHash, _users[0].PasswordSalt));
            
            //Call endpoint and check Ok and user modifications
            response = usersController.ResetPassword(new PasswordResetModel(
                _users[0].Email, tokenCreationParams.TokenStr, "new-password-u1")
            );
            Assert.IsType<OkResult>(response);
            Assert.True(PasswordVerifier.VerifyPasswordHash("new-password-u1", _users[0].PasswordHash, _users[0].PasswordSalt));
            Assert.Null(_users[0].RecoverySalt);
        }
    }
}