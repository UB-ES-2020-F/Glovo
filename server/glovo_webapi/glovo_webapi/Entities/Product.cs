using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
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
        
        [Required, ForeignKey("Restaurant")]
        public int RestaurantId { get; set; }
        
        public ProductCategory Category { get; set; }
        
        public Restaurant Restaurant { get; set; }
        public IEnumerable<OrderProduct> OrdersProducts { get; set; }

        public Product() {}
        
        public Product(string name, string imgPath, string description, float price, int restaurantId, ProductCategory category)
        {
            Name = name;
            ImgPath = imgPath;
            Description = description;
            Price = price;
            RestaurantId = restaurantId;
            Category = category;
        }

    }
}