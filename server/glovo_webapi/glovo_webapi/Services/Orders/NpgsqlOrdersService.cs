using System;
using System.Collections.Generic;
using System.Linq;
using glovo_webapi.Data;
using glovo_webapi.Entities;
using glovo_webapi.Services.UserService;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;

namespace glovo_webapi.Services.Orders
{
    public class NpgsqlOrdersService : IOrdersService
    {
        private readonly GlovoDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public NpgsqlOrdersService(GlovoDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }
        
        public IEnumerable<Order> GetAllOrders()
        {
            return _context.Orders
                .Include(order => order.Restaurant)
                .Include(order => order.User)
                .Include(order => order.OrdersProducts)
                .ToList();
        }

        public Order GetOrderById(int orderId)
        {
            return _context.Orders
                .Include(order => order.Restaurant)
                .Include(order => order.User)
                .Include(order => order.OrdersProducts)
                .FirstOrDefault(o => o.Id == orderId);
        }

        public Order AddOrder(Order order)
        {
            //Check restaurant 
            Restaurant orderRestaurant = (Restaurant) _context.Restaurants.FirstOrDefault(r => r.Id == order.RestaurantId);
            if (orderRestaurant == null) { throw new RequestException(OrderExceptionCodes.RestaurantNotFound); }
            
            //Check all products exist
            foreach (OrderProduct orderProduct in order.OrdersProducts) {
                if(orderProduct == null) {throw new RequestException(OrderExceptionCodes.BadOrderProduct);}
                Product product = _context.Products.FirstOrDefault(p => p.Id == orderProduct.ProductId);
                if (product == null) {throw new RequestException(OrderExceptionCodes.ProductNotFound);}
            }
            
            //Add logged user Id to order
            User loggedUser = (User) _httpContextAccessor.HttpContext.Items["User"];
            order.UserId = loggedUser.Id;
            
            //Add order to database
            order.Id = 0;
            _context.Orders.Add(order);
            _context.SaveChanges();

            return order;
        }
        
        public IEnumerable<Order> GetAllOrdersOfUser(int userId)
        {
            return _context.Orders
                .Include(order => order.Restaurant)
                .Include(order => order.User)
                .Include(order => order.OrdersProducts)
                .Where(o => o.User.Id == userId).ToList();
        }

        public Order GetOrderOfUserById(int userId, int orderId)
        {
            return _context.Orders
                .Include(order => order.Restaurant)
                .Include(order => order.User)
                .Include(order => order.OrdersProducts)
                .FirstOrDefault(o => o.User.Id == userId && o.Id == orderId);
        }

        public IEnumerable<Order> GetAllOrdersOfRestaurant(int restId)
        {
            return _context.Orders
                .Include(order => order.Restaurant)
                .Include(order => order.User)
                .Include(order => order.OrdersProducts)
                .Where(o => o.Restaurant.Id == restId).ToList();
        }

        public Order GetOrderOfRestaurantById(int restId, int orderId)
        {
            return _context.Orders
                .Include(order => order.Restaurant)
                .Include(order => order.User)
                .Include(order => order.OrdersProducts)
                .FirstOrDefault(o => o.Restaurant.Id == restId && o.Id == orderId);
        }
    }
}