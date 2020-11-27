using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Location
{
    public class LocationModel
    {
        [Required]
        [Range(-90, 90)]
        public double? Latitude { get; set; }

        [Required]
        [Range(-180, 180)]
        public double? Longitude { get; set; }
    }
}