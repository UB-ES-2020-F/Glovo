using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Dtos
{
        public class RestaurantReadDto
        {
                public int Id { get; set; }
                
                public string Name { get; set; }
                
                public string ImgPath { get; set; }

                public RestaurantReadDto(int Id, string Name, string ImgPath)
                {
                        this.Id = Id;
                        this.Name = Name;
                        this.ImgPath = ImgPath;
                }
                
        }
}