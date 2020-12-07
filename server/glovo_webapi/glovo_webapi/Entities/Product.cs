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

        public Product(int id, string name, string imgPath, string description, float price, int restaurantId)
        {
            this.Id = id;
            this.Name = name;
            this.ImgPath = imgPath;
            this.Description = description;
            this.Price = price;
            this.RestaurantId = restaurantId;
            this.OrdersProducts = new List<OrderProduct>();
        }

    }
}