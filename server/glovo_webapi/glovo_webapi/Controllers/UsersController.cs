using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.Extensions.Options;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using glovo_webapi.Services;
using glovo_webapi.Entities;
using glovo_webapi.Models.Users;
using glovo_webapi.Services.UserService;
using Microsoft.Extensions.FileProviders;

namespace glovo_webapi.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        private IUserService _userService;
        private IMapper _mapper;
        private string tokenKey = "my-secret-token-key";

        public UsersController(
            IUserService userService,
            IMapper mapper)
        {
            _userService = userService;
            _mapper = mapper;
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Authenticate([FromBody]LoginModel model)
        {
            User user = null;
            try {
                user = _userService.Authenticate(model.Email, model.Password);
            } catch (RequestException) {
                return BadRequest(new { error="login-01", message = "Username or password is incorrect" });
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(tokenKey);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            // return basic user info and authentication token
            return Ok(new
            {
                Id = user.Id,
                Name = user.Name,
                Email = user.Email,
                Token = tokenString
            });
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public IActionResult Register([FromBody]RegisterModel model)
        {
            // map model to entity
            var user = _mapper.Map<User>(model);

            try {
                // create user
                _userService.Create(user, model.Password);
                return Ok();
            } catch (RequestException ex) {
                // return error message if there was an exception
                if (ex.Code == UserExceptionCodes.BadPassword)
                {
                    return BadRequest(new { error="regis-02",message = "password doesn't meet requirements" });
                }
                else if (ex.Code == UserExceptionCodes.UserAlreadyExists)
                {
                    return BadRequest(new { error="regis-01",message = "email already in use" });
                }
                return BadRequest(new {message = "unknown error"});
            }
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            var users = _userService.GetAll();
            var model = _mapper.Map<IList<UserModel>>(users);
            return Ok(model);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            User user = null;
            try
            {
                user = _userService.GetById(id);
            }
            catch (RequestException)
            {
                return NotFound(new {message = "user id not found"});
            }
            var model = _mapper.Map<UserModel>(user);
            return Ok(model);
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody]UpdateUserModel model)
        {
            // map model to entity and set id
            var user = _mapper.Map<User>(model);
            user.Id = id;

            try
            {
                // update user 
                _userService.Update(user, model.Password);
                return Ok();
            }
            catch (RequestException ex)
            {
                if (ex.Code == UserExceptionCodes.BadPassword)
                {
                    return BadRequest(new { error="regis-02",message = "password doesn't meet requirements" });
                }
                else if (ex.Code == UserExceptionCodes.UserAlreadyExists)
                {
                    return BadRequest(new { error="regis-01",message = "email already in use" });
                }
                return BadRequest(new {message = "unknown error"});
            }
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                _userService.Delete(id);
            }
            catch (RequestException)
            {
                return NotFound(new {message = "user id not found"});
            }
            return Ok();
        }
    }
}