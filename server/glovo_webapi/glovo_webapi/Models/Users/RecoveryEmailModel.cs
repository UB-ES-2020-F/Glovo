using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Users
{
    public class RecoveryEmailModel
    {
        [Required]
        public string Email { get; set; }
    }
}