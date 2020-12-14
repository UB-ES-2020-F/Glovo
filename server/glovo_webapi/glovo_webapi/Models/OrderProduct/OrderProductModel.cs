using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Models.OrderProduct
{
    
    //Send
    public class OrderProductModel
    {
        [Required]
        public int? ProductId { get; set; }
        [Required]
        //[AssertThat("Quantity > 0", ErrorMessage = "Quantity must be greater than 0")]
        public int? Quantity { get; set; }

        public OrderProductModel() {}
        
        public OrderProductModel(int productId, int quantity)
        {
            ProductId = productId;
            Quantity = quantity;
        }
    }
}