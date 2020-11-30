using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;
using glovo_webapi.Models.Product;
using glovo_webapi.Services.Orders;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Orders
{
    [ApiController]
    [Route("api/restaurants")]
    public class OrdersOfRestaurantController : ControllerBase
    {
        private readonly IOrdersService _service;
        private readonly IMapper _mapper;
        
        public OrdersOfRestaurantController(IOrdersService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
        
        //GET api/restaurants/<restId>/orders
        [HttpGet("{restId}/orders")]
        [Authorize(Roles="Administrator")]
        public ActionResult<IEnumerable<GetOrderModel>> GetAllOrdersOfRestaurant(int restId)
        {
            IEnumerable<Order> restaurantOrders = _service.GetAllOrdersOfRestaurant(restId);
            if (restaurantOrders == null) { return NotFound(new {message = "restaurant id not found"}); }
            return Ok(_mapper.Map<IEnumerable<GetOrderModel>>(restaurantOrders));
        }
        
        //GET api/restaurants/<restId>/orders/<orderId>
        [HttpGet("{restId}/orders/{orderId}")]
        [Authorize(Roles="Administrator")]
        public ActionResult<GetOrderModel> GetProductOfRestaurantById(int restId, int orderId)
        {
            Order foundOrder = _service.GetOrderOfRestaurantById(restId, orderId);
            if (foundOrder == null) { return NotFound(new {message = "restaurant id or order id not found"}); }
            return Ok(_mapper.Map<GetOrderModel>(foundOrder));            
        }
    }
}