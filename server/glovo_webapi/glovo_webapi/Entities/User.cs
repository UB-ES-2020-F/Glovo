using System.ComponentModel.DataAnnotations;
using glovo_webapi.Utils;

namespace glovo_webapi.Entities
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Email { get; set; }
        public byte[] PasswordHash { get; set; }
        public byte[] PasswordSalt { get; set; }
        public byte[] AuthSalt { get; set; }
        
        [Required]
        public UserRole Role { get; set; }
    }
}