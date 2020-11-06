using System.ComponentModel.DataAnnotations;
using glovo_webapi.Utils;

namespace glovo_webapi.Entities
{
        public class Product
        {
                [Key]
                public int Id { get; set; }
                
                [Required]
                public string Name { get; set; }
                
                public string ImgPath { get; set; }
                
                public string Description { get; set; }
                
                [Required]
                public float Price { get; set; }
                
                [Required]
                public int RestaurantId { get; set; }
                
                [Required]
                public Restaurant Restaurant { get; set; }
                
                public ProductCategory Category { get; set; }

                public Product(int Id, string Name, string ImgPath, string Description, float Price, int RestaurantId)
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