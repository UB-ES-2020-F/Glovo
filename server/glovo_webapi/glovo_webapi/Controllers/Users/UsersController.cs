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
using NetTopologySuite.Geometries;

namespace glovo_webapi.Controllers
{
    //[Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private IUserService _userService;
        private IMapper _mapper;
        private readonly IOptions<AppConfiguration> _configuration;

        public UsersController(
            IUserService userService,
            IMapper mapper,
            IOptions<AppConfiguration> configuration)
        {
            _userService = userService;
            _mapper = mapper;
            _configuration = configuration;
        }

        //POST api/users/login
        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Authenticate([FromBody]LoginModel model)
        {
            User user = null;
            try {
                user = _userService.Authenticate(model.Email, model.Password);
            } catch (RequestException) {
                return BadRequest(new { error="login-01", message = "email or password is incorrect" });
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration.Value.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("id", user.Id.ToString()) }),
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

        //POST api/users/register
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

        //GET api/users
        [HttpGet]
        public IActionResult GetAll()
        {
            var users = _userService.GetAll();
            var model = _mapper.Map<IList<UserModel>>(users);
            return Ok(model);
        }

        //GET api/users/<userId>
        [HttpGet("{userId}")]
        public IActionResult GetById(int userId)
        {
            User user = null;
            try
            {
                user = _userService.GetById(userId);
            }
            catch (RequestException)
            {
                return NotFound(new {message = "user id not found"});
            }
            var model = _mapper.Map<UserModel>(user);
            return Ok(model);
        }

        //PUT api/users/<userId>
        [HttpPut("{userId}")]
        public IActionResult Update(int userId, [FromBody]UpdateUserModel model)
        {
            // map model to entity and set id
            var user = _mapper.Map<User>(model);
            user.Id = userId;

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
                    return BadRequest(new { error="update_usr-01",message = "password doesn't meet requirements" });
                }
                else if (ex.Code == UserExceptionCodes.UserAlreadyExists)
                {
                    return BadRequest(new { error="update_usr-02",message = "email already in use" });
                }
                return BadRequest(new { error="update_usr-03",message = "unknown error"});
            }
        }

        //DELETE api/users/<userId>
        [HttpDelete("{userId}")]
        public IActionResult Delete(int userId)
        {
            try
            {
                _userService.Delete(userId);
            }
            catch (RequestException)
            {
                return NotFound(new {message = "user id not found"});
            }
            return Ok();
        }
        
        //GET api/users/logged/location
        [Authorize]
        [HttpGet]
        public IActionResult GetUserLocation()
        {
            User loggedUser;
            try
            {
                loggedUser = _userService.GetLogged();
            }
            catch (RequestException ex)
            {
                if (ex.Code == UserExceptionCodes.BadPassword)
                {
                    return BadRequest(new { error="location_usr-01",message = "bad session"});
                }
                return BadRequest(new { error="location_usr-02",message = "unknown error"});
            }
            return Ok(loggedUser.Location);
        }
        
        //POST api/users/logged/location
        [Authorize]
        [HttpGet]
        public IActionResult PostUserLocation([FromBody]Point newLocation)
        {
            User loggedUser;
            try
            {
                loggedUser = _userService.GetLogged();
            }
            catch (RequestException ex)
            {
                if (ex.Code == UserExceptionCodes.BadPassword)
                {
                    return BadRequest(new { error="location_usr-01",message = "bad session"});
                }
                return BadRequest(new { error="location_usr-02",message = "unknown error"});
            }

            loggedUser.Location = newLocation;
            try
            {
                _userService.Update(loggedUser);
            }
            catch (RequestException ex)
            {
                if (ex.Code == UserExceptionCodes.UserNotFound)
                {
                    return BadRequest(new { error="location_usr-01",message = "bad session"});
                }
                return BadRequest(new { error="location_usr-02",message = "unknown error"});
            }

            return Ok(loggedUser.Location);
        }
    }
}