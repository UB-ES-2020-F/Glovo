using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Location
{
    
    //Send and Receive
    public class LocationModel
    {
        [Required]
        [Range(-90, 90, ErrorMessage = "Latitude must be between -90 and 90")]
        public double? Latitude { get; set; }
        [Required]
        [Range(-180, 180, ErrorMessage = "Longitude must be between -90 and 90")]
        public double? Longitude { get; set; }
        
        public LocationModel() {}

        public LocationModel(double latitude, double longitude)
        {
            Latitude = latitude;
            Longitude = longitude;
        }
    }
}