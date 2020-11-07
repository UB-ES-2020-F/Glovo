namespace glovo_webapi.Models.Restaurant
{
        public class RestaurantReadModel
        {
                public int Id { get; set; }
                
                public string Name { get; set; }
                
                public string ImgPath { get; set; }
                
                public RestaurantReadModel(int Id, string Name, string ImgPath)
                {
                        this.Id = Id;
                        this.Name = Name;
                        this.ImgPath = ImgPath;
                }
                
        }
}