using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    
    //Receive
    public class RegisterUserModel
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }
        
        public RegisterUserModel() {}

        public RegisterUserModel(string name, string email, string password)
        {
            Name = name;
            Email = email;
            Password = password;
        }
    }
}