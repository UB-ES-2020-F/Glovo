using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace glovo_webapi.Entities
{
    public class OrderProduct
    {
        [Key, Column(Order = 1)]
        public int OrderId { get; set; }
        
        [Key, Column(Order = 2)]
        public int ProductId { get; set; }
        
        public Order Order { get; set; }
        
        public Product Product { get; set; }

        public int Quantity { get; set; }
    }
}