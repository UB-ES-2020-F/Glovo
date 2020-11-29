using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using Microsoft.Extensions.Options;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Security.Cryptography;
using glovo_webapi.Services;
using glovo_webapi.Entities;
using glovo_webapi.Models;
using glovo_webapi.Models.Users;
using glovo_webapi.Services.UserService;
using glovo_webapi.Helpers;
using glovo_webapi.Models.Location;
using glovo_webapi.Utils;
using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using MimeKit.Text;

namespace glovo_webapi.Controllers.Users
{
    
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private IUserService _userService;
        private IMapper _mapper;
        private TokenCreatorValidator _tokenCreatorValidator;

        public UsersController(
            IUserService userService,
            IMapper mapper,
            IOptions<AppConfiguration> configuration)
        {
            _userService = userService;
            _mapper = mapper;
            _tokenCreatorValidator = new TokenCreatorValidator(_userService, configuration);
        }

        //POST api/users/login
        [HttpPost("login")]
        public IActionResult Authenticate([FromBody]LoginModel model)
        {
            User user = null;
            try {
                user = _userService.Authenticate(model.Email, model.Password);
            } catch (RequestException) {
                return BadRequest(new { error="login-01", message = "email or password is incorrect" });
            }
            
            TokenCreationParams tokenCreationParams = _tokenCreatorValidator.CreateToken(user, 60 * 24 * 7);

            user.AuthSalt = tokenCreationParams.SaltBytes;
            _userService.Update(user);
            
            // return basic user info and authentication token
            return Ok(new
            {
                Id = user.Id,
                Name = user.Name,
                Email = user.Email,
                Token = tokenCreationParams.TokenStr
            });
        }

        //POST api/users/register
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
        
        [Authorize(Roles="Regular, Administrator")]
        [HttpPost("logout")]
        public IActionResult Logout()
        {
            User user = (User)HttpContext.Items["User"];
            user.AuthSalt = null;
            _userService.Update(user);
            return Ok();
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
            User user = _userService.GetById(userId);
            User loggedUser = (User)HttpContext.Items["User"];
            if (user == null)
            {
                return NotFound(new {message = "user id not found"});
            }
            if (loggedUser.Role == UserRole.Regular && user.Id != loggedUser.Id)
            {
                return Unauthorized(new {message = "Unauthorized"});
            }
            var model = _mapper.Map<UserModel>(user);
            return Ok(model);
        }

        //PUT api/users/update
        [Authorize(Roles="Regular, Administrator")]
        [HttpPut("update")]
        public IActionResult Update([FromBody]UpdateUserModel model)
        {
            // map model to entity and set id
            User targetUser = (User)HttpContext.Items["User"];
            var user = _mapper.Map<User>(model);
            user.Id = targetUser.Id;

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
        [Authorize(Roles="Regular, Administrator")]
        [HttpDelete("{userId}")]
        public IActionResult Delete(int userId)
        {
            User loggedUser = (User)HttpContext.Items["User"];
            if (loggedUser.Role == UserRole.Regular && userId != loggedUser.Id)
            {
                return Unauthorized(new {message = "Unauthorized"});
            }
            
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
        [HttpGet("logged/location")]
        public IActionResult GetUserLocation()
        {
            User loggedUser = _userService.GetLogged();

            return Ok(_mapper.Map<LocationModel>(loggedUser.Location));
        }
        
        //POST api/users/logged/location
        [Authorize]
        [HttpPost("logged/location")]
        public IActionResult PostUserLocation([FromBody]LocationModel newLocation)
        {
            User loggedUser = _userService.GetLogged();

            loggedUser.Location = _mapper.Map<Location>(newLocation);
            
            try
            {
                _userService.Update(loggedUser);
            }
            catch (Exception)
            {
                return BadRequest(new { error="location_usr-02",message = "unknown error"});
            }
            
            return Ok(_mapper.Map<LocationModel>(loggedUser.Location));
        }
        
        //POST api/users/password-email
        [HttpPost("password-email")]
        public IActionResult SendPasswordEmail([FromBody] RecoveryEmailModel recovEmailModel)
        {
            User user = null;
            try {
                user = _userService.GetByEmail(recovEmailModel.Email);
            } catch (RequestException) {
                return BadRequest(new { error="recov-01", message = "email is incorrect" });
            }

            TokenCreationParams tokenCreationParams = _tokenCreatorValidator.CreateToken(user, 30);

            user.RecoverySalt = tokenCreationParams.SaltBytes;
            _userService.Update(user);
            
            //Send mail with mail and token link
            var message = new MimeMessage ();
            message.From.Add (new MailboxAddress ("Komet Account Recovery Bot", "glovopwdrecov@gmail.com"));
            message.To.Add (new MailboxAddress (user.Name, user.Email));
            message.Subject = "Restore Komet Account Password";

            string link = tokenCreationParams.TokenStr;
            message.Body = new TextPart ("plain") {
                Text = "A password restoration of your account has been issued. If you want to change your password, go to this link:\n" + link
            };

            using (var client = new SmtpClient ()) {
                client.Connect ("smtp.gmail.com", 587, false);

                // Note: only needed if the SMTP server requires authentication
                client.Authenticate ("kometpwdrecov@gmail.com", "glovodevpassword");

                client.Send (message);
                client.Disconnect (true);
            }

            return Ok(new
            {
                Email = user.Email
            });
        }
        
        //POST api/users/reset-password
        [HttpPost("reset-password")]
        public IActionResult ResetPassword([FromBody]PasswordResetModel passwordResetModel)
        {
            User user = null;
            try {
                user = _userService.GetByEmail(passwordResetModel.Email);
            } catch (RequestException) {
                return BadRequest(new { error="recov-01", message = "email does not exist" });
            }

            TokenValidationParams tokenValidationParams;
            try
            {
                tokenValidationParams = _tokenCreatorValidator.ValidateToken(passwordResetModel.RecoveryToken);
            }
            catch (Exception)
            {
                return BadRequest(new { error="recov-02", message = "unknonwn error" });
            }
            
            if (Encoding.Default.GetString(tokenValidationParams.User.RecoverySalt) != 
                Encoding.Default.GetString(tokenValidationParams.SaltBytes))
            {
                return BadRequest(new { error="recov-03", message = "recovery-not-available" });
            }

            user.RecoverySalt = null;
            _userService.Update(user, passwordResetModel.NewPassword);

            return Ok();
        }
        
    }
}