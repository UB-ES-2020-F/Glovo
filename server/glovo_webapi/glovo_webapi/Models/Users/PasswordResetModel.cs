using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    
    //Send
    public class PasswordResetModel
    {
        public string Email { get; set; }
        public string RecoveryToken { get; set; }
        public string NewPassword { get; set; }
    }
}