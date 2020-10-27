using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    public class LoginModel
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
        [Required] 
        public string Name { get; set; }
    }
}