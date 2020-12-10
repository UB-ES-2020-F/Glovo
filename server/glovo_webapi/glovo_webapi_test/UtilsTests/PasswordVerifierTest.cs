using System;
using System.Linq;
using glovo_webapi.Helpers;
using glovo_webapi.Utils;
using Xunit;

namespace glovo_webapi_test.UtilsTests
{
    public class PasswordVerifierTest
    {
        private static readonly Random Random = new Random();
        
        private string RandomString(int length)
        {
            const string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[Random.Next(s.Length)]).ToArray());
        }
        
        [Fact]
        public void CreateAndVerifyPasswordHashTest()
        {
            string password;
            byte[] passwordHash, passwordSalt;

            for (int i = 0; i < 100; i++)
            {
                password = RandomString(Random.Next(1, 33));
                PasswordVerifier.CreatePasswordHash(password, out passwordHash, out passwordSalt);
                Assert.True(PasswordVerifier.VerifyPasswordHash(password, passwordHash, passwordSalt));
            }
        }
    }
}