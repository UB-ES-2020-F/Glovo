using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    
    //Receive
    public class UpdateUserModel
    {
        public string Name { get; set; }
        public string Email { get; set; }
    }
}