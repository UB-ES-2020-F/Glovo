using System.Collections.Generic;
using glovo_webapi.Models;

namespace glovo_webapi.Services
{
    public interface IRestaurantsService
    {
        IEnumerable<Restaurant> GetAllRestaurants();
        Restaurant GetRestaurantById(int id);
    }
}