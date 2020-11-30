using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.UserService
{
    public interface IUsersService
    {
        User Authenticate(string email, string password);
        IEnumerable<User> GetAll();
        User GetById(int id);
        User GetByEmail(string email);
        User GetLogged();
        User Create(User user, string password);
        void Update(User user, string password = null);
        void Delete(int id);
    }
}