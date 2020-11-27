using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Location;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Utils;

namespace glovo_webapi.Profiles
{
    public class LocationsProfile : Profile
    {
        public LocationsProfile()
        {
            CreateMap<LocationModel, Location>();
            CreateMap<Location, LocationModel>();
        }
    }
}