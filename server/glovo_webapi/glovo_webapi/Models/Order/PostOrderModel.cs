using System;
using System.Collections.Generic;
using glovo_webapi.Models.OrderProduct;

namespace glovo_webapi.Models.Order
{
    public class PostOrderModel
    {
        public DateTime BuyDateTime { get; set; }
        
        public int RestaurantId { get; set; }
        
        public IEnumerable<OrderProductModel> OrdersProducts { get; set; }
    }
}