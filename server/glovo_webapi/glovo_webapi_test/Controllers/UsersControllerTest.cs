using AutoMapper;
using glovo_webapi.Controllers.Users;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Helpers;
using glovo_webapi.Models.Users;
using glovo_webapi.Profiles;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace glovo_webapi_test.Controllers
{
    
    public class UsersControllerTest
    {    
        private DbContextOptions<GlovoDbContext> ContextOptions { get; }

        public UsersControllerTest()
        {
            ContextOptions = new DbContextOptionsBuilder<GlovoDbContext>()
                .UseSqlite("Filename=Test.db")
                .Options;
            
            SeedDatabase();
        }

        private IUsersService _usersService;
            
        private User _u1, _u2;
        
        private void SeedDatabase()
        {
            var context = new GlovoDbContext(ContextOptions);
            
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();

            _u1 = new User("u1", "u1@komet.net", "password-u1", new Location(0, 0), UserRole.Regular);
            _u2 = new User("u2", "u2@komet.net", "password-u2", new Location(0, 0), UserRole.Regular);
            
            context.Add(_u1);
            context.Add(_u2);
            context.SaveChanges();
        }
        
        private UsersController CreateFakeUsersController(User loggedUser = null)
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
                cfg.AddProfile<UsersProfile>();
            }).CreateMapper();
            
            //Create UsersController instance with the RestApiUsersService instance and the mapper
            var usersController = new UsersController(_usersService, mapper) {
                ControllerContext = {HttpContext = httpContext}
            };

            return usersController;
        }
        
        [Fact]
        public void UpdateUserTest()
        {
            UsersController usersController = CreateFakeUsersController(_u1);
            
            //Update with non-already existing email
            usersController.Update(
                new UpdateUserModel("new-u1", "new-u1@komet.net")
            );
            
            Assert.Equal("new-u1", _u1.Name);
            Assert.Equal("new-u1@komet.net", _u1.Email);
            
            //Updating with already existing email
            var actionResult = usersController.Update(
                new UpdateUserModel("u2", "u2@komet.net")
            );
            
            Assert.IsType<BadRequestObjectResult>(actionResult);
            Assert.Equal("new-u1", _u1.Name);
            Assert.Equal("new-u1@komet.net", _u1.Email);
        }
        
        [Fact]
        public void UpdatePasswordTest()
        {
            UsersController usersController = CreateFakeUsersController(_u1);
            
            //Update password with correct newPassword
            usersController.UpdatePassword(
                new PasswordUpdateModel("password-u1", "new-password-u1")
                );
            
            Assert.True(PasswordVerifier.VerifyPasswordHash(
                "new-password-u1", _u1.PasswordHash, _u1.PasswordSalt
                ));
            
            //Update password with incorrect newPassword
            var actionResult = usersController.UpdatePassword(
                new PasswordUpdateModel("password-u1", "renew-password-u1")
            );
            
            Assert.IsType<BadRequestObjectResult>(actionResult);
            Assert.True(PasswordVerifier.VerifyPasswordHash(
                "new-password-u1", _u1.PasswordHash, _u1.PasswordSalt
            ));
        }
    }
}