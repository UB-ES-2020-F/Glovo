using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace glovo_webapi.Entities
{
    public class OrderProduct
    {
        [Key, ForeignKey("Order")]
        public int OrderId { get; set; }
        
        [Key, ForeignKey("Product")]
        public int ProductId { get; set; }
        
        [Required]
        public int Quantity { get; set; }
        
        public Order Order { get; set; }
        public Product Product { get; set; }
        
    }
}