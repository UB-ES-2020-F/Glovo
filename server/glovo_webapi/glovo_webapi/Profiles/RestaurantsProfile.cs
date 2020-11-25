using System;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Restaurant;

namespace glovo_webapi.Profiles
{
    public class CustomDistanceResolver : IValueResolver<Restaurant, ViewRestaurantModel, double?>
    {
        public double? Resolve(Restaurant restaurant, ViewRestaurantModel viewRestaurantModel, double? member, ResolutionContext context)
        {
            if (context.Items["userLocation"] == null)
            {
                return null;
            }
            return restaurant.Location.DistanceTo((Location) context.Items["userLocation"]);
        }
    }
    
    public class CustomDeliveryFeeResolver : IValueResolver<Restaurant, ViewRestaurantModel, double?>
    {
        public double? Resolve(Restaurant restaurant, ViewRestaurantModel viewRestaurantModel, double? member, ResolutionContext context)
        {
            if (context.Items["userLocation"] == null || context.Items["deliveryFeeCalculator"] == null)
            {
                return null;
            }
            
            double distance = restaurant.Location.DistanceTo((Location) context.Items["userLocation"]);
            return ((Func<double, double>) context.Items["deliveryFeeCalculator"]).Invoke(distance);
        }
    }
    
    public class RestaurantsProfile : Profile
    {
        public RestaurantsProfile()
        {
            CreateMap<Restaurant, RestaurantModel>();

            CreateMap<Restaurant, ViewRestaurantModel>()
                .ForMember(
                    viewRestaurantModel => viewRestaurantModel.Distance,
                    opts => opts.MapFrom<CustomDistanceResolver>())
                .ForMember(
                    viewRestaurantModel => viewRestaurantModel.DeliveryFee,
                    opts => opts.MapFrom<CustomDeliveryFeeResolver>())
                ;
        }
    }
}