using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Microsoft.IdentityModel.Tokens;

namespace glovo_webapi.Utils
{
    public class TokenCreationParams
    {
        public string TokenStr { get; set; }
        public byte[] SaltBytes { get; set; }

        public TokenCreationParams(string tokenStr, byte[] saltBytes)
        {
            TokenStr = tokenStr;
            SaltBytes = saltBytes;
        }
    }
    
    public class TokenValidationParams
    {
        public int UserId { get; set; }
        public byte[] SaltBytes { get; set; }

        public TokenValidationParams(int userId, byte[] saltBytes)
        {
            UserId = userId;
            SaltBytes = saltBytes;
        }
    }
    
    public class TokenCreatorValidator
    {
        private readonly string _encodingKey;

        public TokenCreatorValidator(string encodingKey)
        {
            _encodingKey = encodingKey;
        }

        public TokenCreationParams CreateToken(int userId, int expirationMinutes)
        {
            var saltBytes = new byte[32];
            using (var generator = new RNGCryptoServiceProvider())
            {
                generator.GetBytes(saltBytes);
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_encodingKey);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] {
                    new Claim("id", userId.ToString()), 
                    new Claim("salt", Encoding.Default.GetString(saltBytes)),
                    }),
                IssuedAt = DateTime.UtcNow,
                Expires = DateTime.UtcNow.AddMinutes(expirationMinutes),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key), 
                    SecurityAlgorithms.HmacSha256Signature
                    )
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenStr = tokenHandler.WriteToken(token);

            return new TokenCreationParams(tokenStr, saltBytes);
        }

        public TokenValidationParams ValidateToken(string tokenStr)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_encodingKey);
            tokenHandler.ValidateToken(tokenStr, new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(key),
                ValidateIssuer = false,
                ValidateAudience = false,
                ClockSkew = TimeSpan.Zero
            }, out SecurityToken validatedToken);
            var jwtToken = (JwtSecurityToken)validatedToken;
            
            var userId = int.Parse(jwtToken.Claims.First(x => x.Type == "id").Value);
            var saltStr = jwtToken.Claims.First(x => x.Type == "salt").Value;
            byte[] saltBytes = Encoding.Default.GetBytes(saltStr);
            
            return new TokenValidationParams(userId, saltBytes);
        }
    }
}