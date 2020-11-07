using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using glovo_webapi.Models.Product;
using glovo_webapi.Models.OrderProduct;

namespace glovo_webapi.Models.Order
{
    public class GetOrderModel
    {
        public int Id { get; set; }
        
        public DateTime BuyDateTime { get; set; }
        
        public int UserId { get; set; }
        
        public int RestaurantId { get; set; }
        
        public IEnumerable<OrderProductModel> OrdersProducts { get; set; }
    }
}