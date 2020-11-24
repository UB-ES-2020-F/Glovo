using System;
using System.ComponentModel.DataAnnotations;
using Newtonsoft.Json;

namespace glovo_webapi.Models
{
    public class Location
    {
        
        public Location() {}
        
        public Location(double? latitude, double? longitude)
        {
            Latitude = latitude;
            Longitude = longitude;
        }

        [Range(-90, 90)]
        public double? Latitude { get; set; }

        [Range(-180, 180)]
        public double? Longitude { get; set; }
    }
}