using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    public class RegisterModel
    {
        [Required] 
        public string Name { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }
    }
}