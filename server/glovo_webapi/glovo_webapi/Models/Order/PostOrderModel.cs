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
        public IEnumerable<OrderProductModel> Products { get; set; }

        public PostOrderModel(int restaurantId, IEnumerable<OrderProductModel> products)
        {
            RestaurantId = restaurantId;
            Products = products;
        }
    }
}