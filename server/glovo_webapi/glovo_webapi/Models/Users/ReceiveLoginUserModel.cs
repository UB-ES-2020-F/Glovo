using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    
    //Receive
    public class ReceiveLoginUserModel
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }
        
        public ReceiveLoginUserModel() {}

        public ReceiveLoginUserModel(string email, string password)
        {
            Email = email;
            Password = password;
        }
    }
}