using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Models;
using glovo_webapi.Models.Restaurant;

namespace  glovo_webapi.Services.Restaurants
{
    public class NpgsqlRestaurantsService : IRestaurantsService
    {
        private readonly GlovoDbContext _context;

        public NpgsqlRestaurantsService(GlovoDbContext context)
        {
            _context = context;
        }
        
        public IEnumerable<Restaurant> GetAllRestaurants()
        {
            return _context.Restaurants.ToList();
        }

        public Restaurant GetRestaurantById(int id)
        {
            return _context.Restaurants.FirstOrDefault(p => p.Id == id);
        }
    }
}