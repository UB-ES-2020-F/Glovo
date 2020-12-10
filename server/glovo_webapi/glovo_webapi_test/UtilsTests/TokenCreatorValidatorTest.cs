using System;
using System.Linq;
using System.Text;
using glovo_webapi.Utils;
using Xunit;

namespace glovo_webapi_test.UtilsTests
{
    public class TokenCreatorValidatorTest
    {
        private static readonly Random Random = new Random();

        private string RandomString(int length)
        {
            const string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[Random.Next(s.Length)]).ToArray());
        }
        
        [Fact]
        public void CreateAndValidateTokenTest()
        {
            TokenCreatorValidator tokenCreatorValidator = new TokenCreatorValidator(
                RandomString(1024)
                );
            int userId;
            
            for (int i = 0; i < 100; i++)
            {
                userId = Random.Next(1, Int32.MaxValue);
                TokenCreationParams tokenCreationParams = tokenCreatorValidator.CreateToken(userId, 30);
                TokenValidationParams tokenValidationParams =
                    tokenCreatorValidator.ValidateToken(tokenCreationParams.TokenStr);
            
                Assert.Equal(userId, tokenValidationParams.UserId);
                Assert.Equal(
                    Encoding.Default.GetString(tokenCreationParams.SaltBytes), 
                    Encoding.Default.GetString(tokenValidationParams.SaltBytes)
                );
            }
            
        }
    }
}