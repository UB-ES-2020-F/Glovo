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
                
                public ICollection<Product> Products { get; set; }

                public Restaurant(int Id, string Name, string ImgPath)
                {
                        this.Id = Id;
                        this.Name = Name;
                        this.ImgPath = ImgPath;
                }
                
        }
}