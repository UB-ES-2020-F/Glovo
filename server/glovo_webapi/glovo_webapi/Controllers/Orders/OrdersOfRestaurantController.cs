using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Helpers;
using glovo_webapi.Models.Order;
using glovo_webapi.Services;
using glovo_webapi.Services.Orders;
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
        [Authorize(Roles = "Administrator")]
        public ActionResult<IEnumerable<GetOrderModel>> GetAllOrdersOfRestaurant(int restId)
        {
            IEnumerable<Order> restaurantOrders;
            try {
                restaurantOrders = _service.GetAllOrdersOfRestaurant(restId);
            } catch (RequestException) {
                return NotFound(new{message = "Restaurant id does not exist"});
            }
            
            return Ok(_mapper.Map<IEnumerable<GetOrderModel>>(restaurantOrders));
        }
    }
}