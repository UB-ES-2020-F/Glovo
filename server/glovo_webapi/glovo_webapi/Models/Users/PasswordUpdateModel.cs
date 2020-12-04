using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    public class PasswordUpdateModel
    {
        [Required]
        public string OldPassword { get; set; }
        [Required]
        public string NewPassword { get; set; }
    }
}