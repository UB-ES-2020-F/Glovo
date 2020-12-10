using System;
using System.Text;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Helpers;
using glovo_webapi.Models.Users;
using glovo_webapi.Services;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace glovo_webapi.Controllers.Users
{
    
    [ApiController]
    [Route("api/users")]
    public class UserAccountController : ControllerBase
    {
        private readonly IUsersService _userService;
        private readonly IMapper _mapper;
        private readonly TokenCreatorValidator _tokenCreatorValidator;

        public UserAccountController(
            IUsersService userService,
            IMapper mapper,
            IOptions<AppConfiguration> configuration)
        {
            _userService = userService;
            _mapper = mapper;
            _tokenCreatorValidator = new TokenCreatorValidator(configuration.Value.Secret);
        }
        
        //POST api/users/login
        [HttpPost("login")]
        public ActionResult<SendLoginUserModel> Authenticate([FromBody]ReceiveLoginUserModel userModel)
        {
            User user;
            try {
                user = _userService.Authenticate(userModel.Email, userModel.Password);
            } catch (RequestException) {
                return BadRequest(new {message = "Email or password is incorrect" });
            }
            
            TokenCreationParams tokenCreationParams = _tokenCreatorValidator.CreateToken(user.Id, 60 * 24 * 7);
            user.AuthSalt = tokenCreationParams.SaltBytes;
            
            _userService.Update(user);

            SendLoginUserModel sendLoginUserModel = _mapper.Map<SendLoginUserModel>(user);
            sendLoginUserModel.Token = tokenCreationParams.TokenStr;
            return Ok(sendLoginUserModel);
        }

        //POST api/users/register
        [HttpPost("register")]
        public ActionResult Register([FromBody]RegisterUserModel userModel)
        {
            // map userModel to entity
            var user = _mapper.Map<User>(userModel);

            try {
                _userService.Create(user, userModel.Password);
            } catch (RequestException ex) {
                if (ex.Code == UserExceptionCodes.BadPassword)
                    return BadRequest(new {message = "Password doesn't meet requirements" });
                if (ex.Code == UserExceptionCodes.EmailAlreadyExists)
                    return BadRequest(new {message = "Email already in use" });
                return BadRequest(new {message = "unknown error"});
            }
            
            return Ok();
        }
        
        [Authorize(Roles="Regular, Administrator")]
        [HttpPost("logout")]
        public ActionResult Logout()
        {
            User loggedUser = (User)HttpContext.Items["User"];
            if(loggedUser == null)
                return NotFound(new {message = "No user is logged"});
            
            loggedUser.AuthSalt = null;
            _userService.Update(loggedUser);
            return Ok();
        }
    }
}