using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using Microsoft.Extensions.Options;
using glovo_webapi.Services;
using glovo_webapi.Entities;
using glovo_webapi.Models.Users;
using glovo_webapi.Services.UserService;
using glovo_webapi.Helpers;
using glovo_webapi.Utils;

namespace glovo_webapi.Controllers.Users
{
    
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly IUsersService _userService;
        private readonly IMapper _mapper;

        public UsersController(
            IUsersService userService,
            IMapper mapper)
        {
            _userService = userService;
            _mapper = mapper;
        }

        //GET api/users
        [Authorize(Roles="Administrator")]
        [HttpGet]
        public IActionResult GetAll()
        {
            var users = _userService.GetAll();
            var model = _mapper.Map<IList<UserModel>>(users);
            return Ok(model);
        }

        //GET api/users/<userId>
        [Authorize(Roles="Regular, Administrator")]
        [HttpGet("{userId}")]
        public IActionResult GetById(int userId)
        {
            User user;
            try {
                user = _userService.GetById(userId);
            } catch(RequestException) {
                return NotFound(new {message = "User id not found"});
            }
            
            User loggedUser = (User)HttpContext.Items["User"];
            if (loggedUser.Role == UserRole.Regular && user.Id != loggedUser.Id)
                return Unauthorized(new {message = "Unauthorized"});
            
            var model = _mapper.Map<UserModel>(user);
            return Ok(model);
        }

        //PUT api/users/update
        [Authorize(Roles="Regular, Administrator")]
        [HttpPut("update")]
        public IActionResult Update([FromBody]UpdateUserModel model)
        {
            //Map userModel to entity and set id
            User user = (User)HttpContext.Items["User"];

            try {
                _userService.SetProfile(user,model.Name, model.Email);
            } catch (RequestException ex) {
                if (ex.Code == UserExceptionCodes.BadPassword)
                    return BadRequest(new {message = "Password doesn't meet requirements" });
                if (ex.Code == UserExceptionCodes.EmailAlreadyExists)
                    return BadRequest(new {message = "Email already in use" });
                return BadRequest(new {message = "Unknown error"});
            }
            
            return Ok();
        }
        
        //PUT api/users/update-password
        [Authorize(Roles="Regular, Administrator")]
        [HttpPut("update-password")]
        public IActionResult UpdatePassword([FromBody]PasswordUpdateModel model)
        {
            //Map userModel to entity and set id
            User user = (User)HttpContext.Items["User"];

            try {
                _userService.SetNewPassword(user,model.NewPassword, model.OldPassword);
            } catch (RequestException ex) {
                if (ex.Code == UserExceptionCodes.BadPassword)
                    return BadRequest(new {message = "Password doesn't meet requirements" });
                if (ex.Code == UserExceptionCodes.InvalidCredentials)
                    return BadRequest(new {message = "Old password doesn't match" });
                return BadRequest(new {message = "Unknown error"});
            }
            
            return Ok();
        }

        //DELETE api/users/<userId>
        [Authorize(Roles="Regular, Administrator")]
        [HttpDelete("{userId}")]
        public IActionResult Delete(int userId)
        {
            User loggedUser = (User)HttpContext.Items["User"];
            if (loggedUser.Role == UserRole.Regular && userId != loggedUser.Id)
                return Unauthorized(new {message = "Unauthorized"});
            
            try {
                _userService.Delete(userId);
            } catch (RequestException) {
                return NotFound(new {message = "User id not found"});
            }
            
            return Ok();
        }
    }
}