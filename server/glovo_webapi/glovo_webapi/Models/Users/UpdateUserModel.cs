using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    
    //Receive
    public class UpdateUserModel
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public string Email { get; set; } 
        [Required]
        public string Password { get; set; }
    }
}