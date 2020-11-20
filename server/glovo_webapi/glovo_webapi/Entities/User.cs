using System.ComponentModel.DataAnnotations.Schema;
using NetTopologySuite.Geometries;

namespace glovo_webapi.Entities
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public byte[] PasswordHash { get; set; }
        public byte[] PasswordSalt { get; set; }
        
        [Column(TypeName="geometry (point)")]
        public Point Location { get; set; }
    }
}