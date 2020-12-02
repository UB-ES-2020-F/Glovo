using System;
using System.Collections.Generic;
using glovo_webapi.Models.OrderProduct;

namespace glovo_webapi.Models.Order
{
    
    //Send
    public class GetOrderModel
    {
        public int Id { get; set; }
        public DateTime BuyDateTime { get; set; }
        public int UserId { get; set; }
        public int RestaurantId { get; set; }
        public IEnumerable<OrderProductModel> Products { get; set; }
    }
}