using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using glovo_webapi.Models.OrderProduct;

namespace glovo_webapi.Models.Order
{
    
    //Receive
    public class PostOrderModel
    {
        [Required]
        public int? RestaurantId { get; set; }
        [Required]
        //[AssertThat("Products.Count() != 0", ErrorMessage = "Longitude must be between -90 and 90")]
        public IEnumerable<OrderProductModel> Products { get; set; }
    }
}