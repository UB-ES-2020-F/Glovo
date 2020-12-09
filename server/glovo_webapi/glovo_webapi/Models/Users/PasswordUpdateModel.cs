using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    public class PasswordUpdateModel
    {
        [Required]
        public string OldPassword { get; set; }
        [Required]
        public string NewPassword { get; set; }
        
        public PasswordUpdateModel() {}

        public PasswordUpdateModel(string oldPassword, string newPassword)
        {
            OldPassword = oldPassword;
            NewPassword = newPassword;
        }
    }
}