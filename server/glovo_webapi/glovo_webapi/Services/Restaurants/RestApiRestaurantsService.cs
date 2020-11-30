using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;

namespace  glovo_webapi.Services.Restaurants
{
    public class RestApiRestaurantsService : IRestaurantsService
    {
        private readonly GlovoDbContext _context;

        public RestApiRestaurantsService(GlovoDbContext context)
        {
            _context = context;
        }
        
        public IEnumerable<Restaurant> GetAllRestaurants()
        {
            return _context.Restaurants.ToList();
        }

        public Restaurant GetRestaurantById(int id)
        {
            Restaurant foundRestaurant = _context.Restaurants.FirstOrDefault(r => r.Id == id);
            if (foundRestaurant == null)
                throw new RequestException(RestaurantExceptionCodes.RestaurantNotFound);

            return foundRestaurant;
        }
    }
}