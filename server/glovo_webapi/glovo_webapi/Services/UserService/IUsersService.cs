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
        User Create(User user, string password);
        void SetProfile(User user, string name, string email);
        void SetNewPassword(User user, string newPassword, string oldPassword=null);
        void Update(User user);
        void Delete(int id);
    }
}