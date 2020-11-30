using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Helpers;
using glovo_webapi.Models.Users;
using glovo_webapi.Services;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
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
            _tokenCreatorValidator = new TokenCreatorValidator(_userService, configuration);
        }
        
        //POST api/users/login
        [HttpPost("login")]
        public IActionResult Authenticate([FromBody]LoginUserModel userModel)
        {
            User user = null;
            try {
                user = _userService.Authenticate(userModel.Email, userModel.Password);
            } catch (RequestException) {
                return BadRequest(new {message = "Email or password is incorrect" });
            }
            
            TokenCreationParams tokenCreationParams = _tokenCreatorValidator.CreateToken(user, 60 * 24 * 7);

            user.AuthSalt = tokenCreationParams.SaltBytes;
            //TODO CATCH EXCEPTIONS
            _userService.Update(user);
            
            //TODO TURN THIS INTO A MODEL CLASS
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
        public IActionResult Register([FromBody]RegisterUserModel userModel)
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
        public IActionResult Logout()
        {
            User user = (User)HttpContext.Items["User"];
            user.AuthSalt = null;
            //TODO CATCH EXCEPTIONS
            _userService.Update(user);
            return Ok();
        }
    }
}