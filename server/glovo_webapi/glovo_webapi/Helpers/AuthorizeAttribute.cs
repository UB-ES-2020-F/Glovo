using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Linq;
using glovo_webapi.Entities;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.Extensions.DependencyInjection;

namespace glovo_webapi.Helpers
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class AuthorizeAttribute : Attribute, IAuthorizationFilter
    {
        public string Roles { get; set; }
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            //var userService = context.HttpContext.RequestServices.GetService<IUserService>();
            var user = (User) context.HttpContext.Items["User"];
            if (user == null)
            {
                // not logged in
                context.Result = new JsonResult(new {message = "Unauthorized"})
                    {StatusCode = StatusCodes.Status401Unauthorized};
                return;
            }
            var roleArray = Roles.Split(',')
                .Select(x => x.Trim())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .ToArray();
            if (roleArray.Length > 0 &&  roleArray.All(x => x != user.Role.ToString()))
            {
                //unauthorized role
                context.Result = new JsonResult(new {message = "Unauthorized"})
                    {StatusCode = StatusCodes.Status401Unauthorized};
            }
        }
    }
}