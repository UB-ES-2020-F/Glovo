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
            _tokenCreatorValidator = new TokenCreatorValidator(_userService, configuration);
        }
        
        //POST api/users/password-email
        [HttpPost("password-email")]
        public IActionResult SendPasswordEmail([FromBody] string recoveryEmail)
        {
            User user;
            try {
                user = _userService.GetByEmail(recoveryEmail);
            } catch (RequestException) {
                return BadRequest(new {message = "Email is incorrect" });
            }

            TokenCreationParams tokenCreationParams = _tokenCreatorValidator.CreateToken(user, 30);

            user.RecoverySalt = tokenCreationParams.SaltBytes;
            
            //TODO CATCH EXCEPTIONS
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
                client.Authenticate ("kometpwdrecov@gmail.com", "glovodevpassword");
                client.Send (message);
                client.Disconnect (true);
            }

            return Ok(new
            {
                user.Email
            });
        }
        
        //POST api/users/reset-password
        [HttpPost("reset-password")]
        public IActionResult ResetPassword([FromBody]PasswordResetModel passwordResetModel)
        {
            User user;
            try {
                user = _userService.GetByEmail(passwordResetModel.Email);
            } catch (RequestException) {
                return BadRequest(new {message = "Email does not exist" });
            }

            TokenValidationParams tokenValidationParams;
            try {
                tokenValidationParams = _tokenCreatorValidator.ValidateToken(passwordResetModel.RecoveryToken);
            } catch (Exception) {
                return BadRequest(new {message = "Invalid token error" });
            }
            
            if (Encoding.Default.GetString(tokenValidationParams.User.RecoverySalt) != 
                Encoding.Default.GetString(tokenValidationParams.SaltBytes))
                return BadRequest(new {message = "Recovery link expired or invalid" });

            user.RecoverySalt = null;
            
            //TODO CATCH EXCEPTIONS
            _userService.Update(user, passwordResetModel.NewPassword);

            return Ok();
        }
    }
}