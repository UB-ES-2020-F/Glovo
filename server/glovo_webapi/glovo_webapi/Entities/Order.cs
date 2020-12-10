using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace glovo_webapi.Entities
{
    public class Order
    {
        [Key]
        public int Id { get; set; }
        
        [Required]
        public DateTime BuyDateTime { get; set; }
        
        [Required, ForeignKey("User")]
        public int UserId { get; set; }
        
        [Required, ForeignKey("Restaurant")]
        public int RestaurantId { get; set; }
        
        public User User { get; set; }
        public Restaurant Restaurant { get; set; }
        public IEnumerable<OrderProduct> OrdersProducts { get; set; }
        
        public Order() {}

        public Order(DateTime buyDateTime, int userId, int restaurantId)
        {
            BuyDateTime = buyDateTime;
            UserId = userId;
            RestaurantId = restaurantId;
        }
    }
}