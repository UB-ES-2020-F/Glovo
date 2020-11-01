using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.Restaurants
{
    public interface IRestaurantsService
    {
        IEnumerable<Restaurant> GetAllRestaurants();
        Restaurant GetRestaurantById(int id);
    }
}