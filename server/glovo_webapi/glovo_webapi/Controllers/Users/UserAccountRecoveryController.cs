using System;
using System.Text;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Users;
using glovo_webapi.Services;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using MailKit.Net.Smtp;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using MimeKit;

namespace glovo_webapi.Controllers.Users
{
    
    [ApiController]
    [Route("api/users")]
    public class UserAccountRecoveryController : ControllerBase
    {
        private readonly IUsersService _userService;
        private readonly IMapper _mapper;
        private readonly TokenCreatorValidator _tokenCreatorValidator;

        public UserAccountRecoveryController(
            IUsersService userService,
            IMapper mapper,
            IOptions<AppConfiguration> configuration)
        {
            _userService = userService;
            _mapper = mapper;
            _tokenCreatorValidator = new TokenCreatorValidator(configuration.Value.Secret);
        }
        
        //POST api/users/password-email
        [HttpPost("password-email")]
        public ActionResult<PasswordEmailModel> SendPasswordEmail([FromBody] PasswordEmailModel passwordEmailModel)
        {
            User user;
            try {
                user = _userService.GetByEmail(passwordEmailModel.Email);
            } catch (RequestException) {
                return BadRequest(new {message = "Email is not found" });
            }

            TokenCreationParams tokenCreationParams = _tokenCreatorValidator.CreateToken(user.Id, 30);

            user.RecoverySalt = tokenCreationParams.SaltBytes;
            _userService.Update(user);

            MailSender.SendRecoveryMail(user, tokenCreationParams.TokenStr);


            return Ok(new PasswordEmailModel(user.Email));
        }
        
        //POST api/users/reset-password
        [HttpPost("reset-password")]
        public ActionResult ResetPassword([FromBody]PasswordResetModel passwordResetModel)
        {
            User user;
            try {
                user = _userService.GetByEmail(passwordResetModel.Email);
            } catch (RequestException) {
                return BadRequest(new {message = "Email does not exist" });
            }
            
            TokenValidationParams tokenValidationParams;
            User tokenUser;
            try {
                tokenValidationParams = _tokenCreatorValidator.ValidateToken(passwordResetModel.RecoveryToken);
                tokenUser = _userService.GetById(tokenValidationParams.UserId);
            } catch (Exception) {
                return BadRequest(new {message = "Invalid token error" });
            }
            
            if (Encoding.Default.GetString(tokenUser.RecoverySalt) != 
                Encoding.Default.GetString(tokenValidationParams.SaltBytes))
                return BadRequest(new {message = "Recovery link expired or invalid" });

            user.RecoverySalt = null;
            
            try {
                _userService.SetNewPassword(user, passwordResetModel.NewPassword);
            }
            catch(RequestException ex) {
                if(ex.Code == UserExceptionCodes.InvalidCredentials)
                    return BadRequest(new {message = "Invalid old password"});
                if(ex.Code == UserExceptionCodes.BadPassword)
                    return BadRequest(new {message = "Invalid new password"});
                return BadRequest(new {message = "Unknown error"});
            }
            
            return Ok();
        }
    }
}