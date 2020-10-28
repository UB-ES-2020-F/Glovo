using AutoMapper;
using glovo_webapi.Dtos.Restaurant;
using glovo_webapi.Models;

namespace glovo_webapi.Profiles
{
    public class RestaurantsProfile : Profile
    {
        public RestaurantsProfile()
        {
            CreateMap<Restaurant, RestaurantReadDto>();
        }
    }
}