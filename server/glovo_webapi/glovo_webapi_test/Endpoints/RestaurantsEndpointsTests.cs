using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using glovo_webapi.Models.Restaurant;
using Newtonsoft.Json;
using Xunit;
using Xunit.Abstractions;

namespace glovo_webapi_test.Endpoints
{
    public class RestaurantsEndpointsTests
    {
        private readonly ITestOutputHelper _output;
        private HttpClient _client;
        private JsonSerializer _serializer;

        private List<RestaurantReadModel> mockRestaurants;
        
        public RestaurantsEndpointsTests(ITestOutputHelper output)
        {
            _output = output;
            _client = new HttpClient();
            _serializer = new JsonSerializer();
            
            mockRestaurants = new List<RestaurantReadModel>
                {
                    new RestaurantReadModel(1, "Kentucky Fried Chicken", "img/KFC_main.jpg"),
                    new RestaurantReadModel(2, "McDonalds", "img/MD_main.jpg"),
                    new RestaurantReadModel(3, "Burger King", "img/BK_main.jpg"),
                    new RestaurantReadModel(4, "Krusty Krab", "img/KK_main.jpg"),
                }
                ;
        }
        
        [Fact]
        public void GetAllRestaurantsTest()
        {
            //Query mock restaurants from DB
            HttpResponseMessage response = _client.GetAsync("https://localhost:5001/api/restaurants").Result;
            string responseBodyStr = response.Content.ReadAsStringAsync().Result;
            List<RestaurantReadModel> queriedRestaurants = (List<RestaurantReadModel>) _serializer.Deserialize<IEnumerable<RestaurantReadModel>>(new JsonTextReader(new StringReader(responseBodyStr)));

            //Check if queried and expected restaurants are the same
            queriedRestaurants.Sort((r1, r2) => r1.Id - r2.Id);
            var restaurants = mockRestaurants.Zip(mockRestaurants, (mockRestaurant, queriedRestaurant) => new { Expected = mockRestaurant, Queried = queriedRestaurant });
            foreach(var restaurantPair in restaurants)
            {
                Assert.Equal(restaurantPair.Expected.Id, restaurantPair.Queried.Id);
                Assert.Equal(restaurantPair.Expected.Name, restaurantPair.Queried.Name);
                Assert.Equal(restaurantPair.Expected.ImgPath, restaurantPair.Queried.ImgPath);
            }
        }
        
        [Fact]
        public void GetRestaurantByIdTest()
        {
            //Query mock restaurants by Id from DB
            List<RestaurantReadModel> queriedRestaurants = new List<RestaurantReadModel>();
            for (int id = 1; id <= 4; id++)
            {
                string endpointUrl = "https://localhost:5001/api/restaurants/" + id.ToString();
                HttpResponseMessage response = _client.GetAsync(endpointUrl).Result;
                string responseBodyStr = response.Content.ReadAsStringAsync().Result;
                RestaurantReadModel queriedRestaurant = (RestaurantReadModel) _serializer.Deserialize<RestaurantReadModel>(new JsonTextReader(new StringReader(responseBodyStr)));
                queriedRestaurants.Add(queriedRestaurant);
            }
            
            //Check if queried and expected restaurants are the same
            queriedRestaurants.Sort((r1, r2) => r1.Id - r2.Id);
            var restaurants = mockRestaurants.Zip(mockRestaurants, (mockRestaurant, queriedRestaurant) => new { Expected = mockRestaurant, Queried = queriedRestaurant });
            foreach(var restaurantPair in restaurants)
            {
                Assert.Equal(restaurantPair.Expected.Id, restaurantPair.Queried.Id);
                Assert.Equal(restaurantPair.Expected.Name, restaurantPair.Queried.Name);
                Assert.Equal(restaurantPair.Expected.ImgPath, restaurantPair.Queried.ImgPath);
            }
        }
    }
}