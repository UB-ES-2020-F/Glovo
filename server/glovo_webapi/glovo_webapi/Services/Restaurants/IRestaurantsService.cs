using System.Collections.Generic;
using glovo_webapi.Models;
using glovo_webapi.Models.Restaurant;

namespace glovo_webapi.Services.Restaurants
{
    public interface IRestaurantsService
    {
        IEnumerable<Restaurant> GetAllRestaurants();
        Restaurant GetRestaurantById(int id);
    }
}