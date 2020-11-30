using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Location;

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