using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    public class PasswordResetModel
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string RecoveryToken { get; set; }
        [Required]
        public string NewPassword { get; set; }
    }
}