using System;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using glovo_webapi;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;

namespace WebApi.Helpers
{
    public class JwtMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IOptions<AppConfiguration> _configuration;

        public JwtMiddleware(RequestDelegate next, IOptions<AppConfiguration> configuration)
        {
            _next = next;
            _configuration = configuration;
        }

        public async Task Invoke(HttpContext context, IUserService userService)
        {
            var tokenStr = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();

            if (tokenStr != null)
                AttachUserToContext(context, userService, tokenStr);

            await _next(context);
        }

        private void AttachUserToContext(HttpContext context, IUserService userService, string tokenStr)
        {
            Console.WriteLine("Attaching user");
            TokenCreatorValidator tokenCreatorValidator = new TokenCreatorValidator(userService, _configuration); 
            try
            {
                TokenValidationParams tokenValidationParams = tokenCreatorValidator.ValidateToken(tokenStr);
                
                if (Encoding.Default.GetString(tokenValidationParams.User.AuthSalt) == 
                    Encoding.Default.GetString(tokenValidationParams.SaltBytes))
                {
                    Console.WriteLine("User attached");
                    context.Items["User"] = tokenValidationParams.User;
                }
            }
            catch
            {
                // do nothing if jwt validation fails
                // user is not attached to context so request won't have access to secure routes
            }
        }
    }
}