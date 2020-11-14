using System.Collections.Generic;
using glovo_webapi.Entities;

namespace glovo_webapi.Services.Orders
{
    public interface IOrdersService
    {
        IEnumerable<Order> GetAllOrders();
        Order GetOrderById(int orderId);
        Order AddOrder(Order order);
        IEnumerable<Order> GetAllOrdersOfUser(int userId);
        Order GetOrderOfUserById(int userId, int orderId);
        IEnumerable<Order> GetAllOrdersOfRestaurant(int restId);
        Order GetOrderOfRestaurantById(int restId, int orderId);
    }
}