using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Users;

namespace glovo_webapi.Profiles
{
    public class UsersProfile : Profile
    {
        public UsersProfile()
        {
            CreateMap<User, UserModel>();
            CreateMap<RegisterModel, User>();
            CreateMap<UpdateUserModel, User>();
        }
    }
}