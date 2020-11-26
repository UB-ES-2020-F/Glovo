using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace glovo_webapi.Entities
{
    [Owned]
    public class Location
    {
        private readonly double _R = 6371;
        
        [Range(-90, 90)]
        public double Latitude { get; set; }

        [Range(-180, 180)]
        public double Longitude { get; set; }

        public double DistanceTo(Location location)
        {
            double latRad1 = Latitude * Math.PI / 180.0;
            double latRad2 = location.Latitude * Math.PI / 180.0;
            double difLat = (Latitude - location.Latitude) * Math.PI / 180.0;
            double difLon = (Longitude - location.Longitude) * Math.PI / 180.0;
            double a = Math.Sin(difLat / 2) * Math.Sin(difLat / 2) +
                       Math.Cos(latRad1) * Math.Cos(latRad2) * Math.Sin(difLon / 2) * Math.Sin(difLon / 2);
            double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));

            return _R * c;
        }
    }
}