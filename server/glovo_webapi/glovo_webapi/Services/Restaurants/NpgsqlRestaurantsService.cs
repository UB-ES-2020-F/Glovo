using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Utils;

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
            return _context.Restaurants.FirstOrDefault(r => r.Id == id);
        }
    }
}