using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Restaurant;

namespace glovo_webapi.Profiles
{
    public class RestaurantsProfile : Profile
    {
        public RestaurantsProfile()
        {
            CreateMap<Restaurant, RestaurantReadModel>();
        }
    }
}