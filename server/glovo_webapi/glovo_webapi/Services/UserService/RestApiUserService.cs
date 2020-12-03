using System;
using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using Microsoft.AspNetCore.Http;

namespace glovo_webapi.Services.UserService
{
    public class RestApiUserService : IUsersService
    {
        private readonly GlovoDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public RestApiUserService(GlovoDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }

        public User Authenticate(string email, string password)
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                throw new RequestException(UserExceptionCodes.InvalidCredentials);

            var user = _context.Users.SingleOrDefault(x => x.Email == email);

            // check if username exists
            if (user == null)
                throw new RequestException(UserExceptionCodes.InvalidCredentials);

            // check if password is correct
            if (!VerifyPasswordHash(password, user.PasswordHash, user.PasswordSalt))
                throw new RequestException(UserExceptionCodes.InvalidCredentials);

            // authentication successful
            return user;
        }

        public IEnumerable<User> GetAll()
        {
            return _context.Users;
        }

        public User GetById(int id)
        {
            User u = _context.Users.Find(id);
            if (u == null)
                throw new RequestException(UserExceptionCodes.UserNotFound);

            return u;
        }

        public User GetByEmail(string email)
        {
            User u = _context.Users.FirstOrDefault(user => user.Email == email);
            if (u == null)
                throw new RequestException(UserExceptionCodes.UserNotFound);

            return u;
        }

        public User GetLogged()
        {
            User loggedUser = (User) _httpContextAccessor.HttpContext.Items["User"];
            if (loggedUser == null)
                throw new RequestException(UserExceptionCodes.NoLoggedUser);
            
            return loggedUser;
        }
        
        public User Create(User user, string password)
        {
            // validation
            if (string.IsNullOrWhiteSpace(password))
                throw new RequestException(UserExceptionCodes.BadPassword);

            if (_context.Users.Any(x => x.Email == user.Email))
                throw new RequestException(UserExceptionCodes.EmailAlreadyExists);

            byte[] passwordHash, passwordSalt;
            CreatePasswordHash(password, out passwordHash, out passwordSalt);

            user.PasswordHash = passwordHash;
            user.PasswordSalt = passwordSalt;

            user.Location = null;
            
            _context.Users.Add(user);
            _context.SaveChanges();

            return user;
        }

        public void Update(User userParam, string password = null)
        {
            var user = _context.Users.Find(userParam.Id);

            if (user == null)
                throw new RequestException(UserExceptionCodes.UserNotFound);

            if (!string.IsNullOrEmpty(userParam.Name))
                user.Name = userParam.Name;
            
            // update username if it has changed
            if (!string.IsNullOrWhiteSpace(userParam.Email) && userParam.Email != user.Email)
            {
                // throw error if the new username is already taken
                if (_context.Users.Any(x => x.Email == userParam.Email))
                    throw new RequestException(UserExceptionCodes.EmailAlreadyExists);

                user.Email = userParam.Email;
            }

            // update password if provided
            if (!string.IsNullOrWhiteSpace(password))
            {
                byte[] passwordHash, passwordSalt;
                CreatePasswordHash(password, out passwordHash, out passwordSalt);

                user.PasswordHash = passwordHash;
                user.PasswordSalt = passwordSalt;
            }

            _context.Users.Update(user);
            _context.SaveChanges();
        }

        public void Delete(int id)
        {
            var user = _context.Users.Find(id);
            if (user == null)
                throw new RequestException(UserExceptionCodes.UserNotFound);

            _context.Users.Remove(user);
            _context.SaveChanges();
        }

        //Private helper methods

        private static void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            if (password == null) throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");

            using var hmac = new System.Security.Cryptography.HMACSHA512();
            passwordSalt = hmac.Key;
            passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        }

        private static bool VerifyPasswordHash(string password, byte[] storedHash, byte[] storedSalt)
        {
            if (password == null) throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");
            if (storedHash.Length != 64) throw new ArgumentException("Invalid length of password hash (64 bytes expected).", "passwordHash");
            if (storedSalt.Length != 128) throw new ArgumentException("Invalid length of password salt (128 bytes expected).", "passwordHash");

            using var hmac = new System.Security.Cryptography.HMACSHA512(storedSalt);
            var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            for (int i = 0; i < computedHash.Length; i++)
            {
                if (computedHash[i] != storedHash[i]) return false;
            }

            return true;
        }
    }
}