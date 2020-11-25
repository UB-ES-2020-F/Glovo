using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.Location
{
    public class LocationModel
    {
        public LocationModel(double latitude, double longitude)
        {
            Latitude = latitude;
            Longitude = longitude;
        }

        [Range(-90, 90)]
        public double Latitude { get; set; }

        [Range(-180, 180)]
        public double Longitude { get; set; }
    }
}