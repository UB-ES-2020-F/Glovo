using System;
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
        
        public byte[] RecoverySalt { get; set; }
        
        public Location Location { get; set; }
        
        [Required]
        public UserRole Role { get; set; }

        public User() {}

        public User(string name, string email, string password, Location location, UserRole role)
        {
            Name = name;
            Email = email;
            if (password == null)
                throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password))
                throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");
            var hmac = new System.Security.Cryptography.HMACSHA512();
            PasswordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            PasswordSalt = hmac.Key;
            AuthSalt = null;
            RecoverySalt = null;
            Location = location;
            Role = role;
        }
    }
}