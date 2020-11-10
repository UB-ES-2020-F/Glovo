namespace glovo_webapi.Models.Product
{
        public class ProductReadModel
        {
                public int Id { get; set; }
                
                public string Name { get; set; }
                
                public string ImgPath { get; set; }
                
                public string Description { get; set; }
                
                public float Price { get; set; }
                
                public int RestaurantId { get; set; }

                public ProductReadModel(int Id, string Name, string ImgPath, string Description, float Price, int RestaurantId)
                {
                        this.Id = Id;
                        this.Name = Name;
                        this.ImgPath = ImgPath;
                        this.Description = Description;
                        this.Price = Price;
                        this.RestaurantId = RestaurantId;
                }
                
        }
}