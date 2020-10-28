using System.Collections.Generic;
using glovo_webapi.Models;

namespace glovo_webapi.Services
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
            return new Restaurant(0, "Kentucky Friend Chicken", "img/stores/KFC_main.jpg");
        }
    }
}