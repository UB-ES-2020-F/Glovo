using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Users;

namespace glovo_webapi.Profiles
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<User, UserModel>();
            CreateMap<RegisterModel, User>();
            CreateMap<UpdateUserModel, User>();
        }
    }
}