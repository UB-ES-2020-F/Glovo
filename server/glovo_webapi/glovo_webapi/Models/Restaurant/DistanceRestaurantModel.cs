namespace glovo_webapi.Models.Restaurant
{
        public class DistanceRestaurantModel
        {
                public int Id { get; set; }
                public string Name { get; set; }
                public string ImgPath { get; set; }
                public double? Distance { get; set; }
                public double? DeliveryFee { get; set; }
                
                public DistanceRestaurantModel() {}
        }
}