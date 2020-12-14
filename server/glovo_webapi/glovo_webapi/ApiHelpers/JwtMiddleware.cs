using System.Linq;
using System.Text;
using System.Threading.Tasks;
using glovo_webapi.Entities;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;

namespace glovo_webapi.Helpers
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

        public async Task Invoke(HttpContext context, IUsersService userService)
        {
            var tokenStr = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();

            if (tokenStr != null)
                AttachUserToContext(context, userService, tokenStr);

            await _next(context);
        }

        private void AttachUserToContext(HttpContext context, IUsersService userService, string tokenStr)
        {
            TokenCreatorValidator tokenCreatorValidator = new TokenCreatorValidator(_configuration.Value.Secret); 
            try
            {
                TokenValidationParams tokenValidationParams = tokenCreatorValidator.ValidateToken(tokenStr);
                User tokenUser = userService.GetById(tokenValidationParams.UserId);
                if (Encoding.Default.GetString(tokenUser.AuthSalt) == 
                    Encoding.Default.GetString(tokenValidationParams.SaltBytes))
                {
                    context.Items["User"] = tokenUser;
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