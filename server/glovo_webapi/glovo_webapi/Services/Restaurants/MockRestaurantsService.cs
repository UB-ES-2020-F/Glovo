using System.Collections.Generic;
using glovo_webapi.Entities;
using glovo_webapi.Utils;

namespace glovo_webapi.Services.Restaurants
{
    public class MockRestaurantsService : IRestaurantsService
    {
        public IEnumerable<Restaurant> GetAllRestaurants()
        {
            return new List<Restaurant>
            {
                new Restaurant(0, "Kentucky Fried Chicken", "img/stores/KFC_main.jpg"),
                new Restaurant(1, "Burger King", "img/stores/BK_main.jpg"),
                new Restaurant(2, "Crustaceo Crujiente", "img/stores/CC_main.jpg")
            };
        }

        public Restaurant GetRestaurantById(int id)
        {
            return new Restaurant(id, "Kentucky Friend Chicken", "img/stores/KFC_main.jpg");
        }
        
    }
}