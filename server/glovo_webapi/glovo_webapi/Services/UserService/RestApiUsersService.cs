using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Http;

namespace glovo_webapi.Services.UserService
{
    public class RestApiUsersService : IUsersService
    {
        private readonly GlovoDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public RestApiUsersService(GlovoDbContext context, IHttpContextAccessor httpContextAccessor)
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
            if (!PasswordVerifier.VerifyPasswordHash(password, user.PasswordHash, user.PasswordSalt))
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

        public User Create(User user, string password)
        {
            // validation
            if (string.IsNullOrWhiteSpace(password))
                throw new RequestException(UserExceptionCodes.BadPassword);

            if (_context.Users.Any(x => x.Email == user.Email))
                throw new RequestException(UserExceptionCodes.EmailAlreadyExists);

            byte[] passwordHash, passwordSalt;
            PasswordVerifier.CreatePasswordHash(password, out passwordHash, out passwordSalt);

            user.PasswordHash = passwordHash;
            user.PasswordSalt = passwordSalt;

            user.Location = null;
            
            _context.Users.Add(user);
            _context.SaveChanges();

            return user;
        }

        public void SetProfile(User user, string name, string email)
        {
            if (!string.IsNullOrWhiteSpace(email) && email != user.Email)
            {
                //Throw error if the new email is already taken
                if (_context.Users.Any(x => x.Email == email))
                    throw new RequestException(UserExceptionCodes.EmailAlreadyExists);

                user.Email = email;
            }
            
            if (!string.IsNullOrEmpty(name))
                user.Name = name;
            
            _context.Users.Update(user);
            _context.SaveChanges();
        }

        public void SetNewPassword(User user, string newPassword, string oldPassword = null)
        {
            if (oldPassword != null && !PasswordVerifier.VerifyPasswordHash(oldPassword, user.PasswordHash, user.PasswordSalt))
                throw new RequestException(UserExceptionCodes.InvalidCredentials);
            
            if (string.IsNullOrWhiteSpace(newPassword))
                throw new RequestException(UserExceptionCodes.BadPassword);
            
            byte[] passwordHash, passwordSalt;
            PasswordVerifier.CreatePasswordHash(newPassword, out passwordHash, out passwordSalt);
            user.PasswordHash = passwordHash;
            user.PasswordSalt = passwordSalt;
            _context.Users.Update(user);
            _context.SaveChanges();
        }

        public void Update(User user)
        {
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
    }
}