using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Entities
{
    public class Restaurant
    {
        [Key]
        public int Id { get; set; }
        
        [Required]
        public string Name { get; set; }
        
        public string ImgPath { get; set; }
        
        [Required]
        public Location Location { get; set; }
        
        public ICollection<Product> Products { get; set; }

        public Restaurant() {}
        
        public Restaurant(string name, string imgPath, Location location)
        {
            Name = name;
            ImgPath = imgPath;
            Location = location;
        }
    }
}