using glovo_webapi.Models.Location;

namespace glovo_webapi.Models.Restaurant
{
        public class LocationRestaurantModel
        {
                public int Id { get; set; }
                
                public string Name { get; set; }
                
                public string ImgPath { get; set; }
                
                public LocationModel Location { get; set; }
        }
}