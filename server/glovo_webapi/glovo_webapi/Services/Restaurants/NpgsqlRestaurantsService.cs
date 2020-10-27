using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Models;

namespace  glovo_webapi.Services
{
    public class NpgsqlRestaurantsService : IRestaurantsService
    {
        private readonly GloboDBContext _context;

        public NpgsqlRestaurantsService(GloboDBContext context)
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