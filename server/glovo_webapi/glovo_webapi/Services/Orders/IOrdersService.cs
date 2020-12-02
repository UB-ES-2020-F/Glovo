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
        IEnumerable<Order> GetAllOrdersOfRestaurant(int restId);
    }
}