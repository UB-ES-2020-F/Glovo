using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace glovo_webapi.Entities
{
    public class Order
    {
        [Key]
        public int Id { get; set; }
        public DateTime BuyDateTime { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
        public int RestaurantId { get; set; }
        public Restaurant Restaurant { get; set; }
        public IEnumerable<OrderProduct> OrdersProducts { get; set; }
    }
}