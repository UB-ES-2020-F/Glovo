using System;
using System.Collections.Generic;
using System.Security.Claims;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;
using glovo_webapi.Services;
using glovo_webapi.Services.Orders;
using glovo_webapi.Services.UserService;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Orders
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly IOrdersService _service;
        private readonly IMapper _mapper;

        public OrdersController(IOrdersService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
        
        //GET api/orders
        [HttpGet]
        public ActionResult<IEnumerable<GetOrderModel>> GetAllOrders()
        {
            IEnumerable<Order> orders = _service.GetAllOrders();
            return Ok(_mapper.Map<IEnumerable<GetOrderModel>>(orders));
        }
        
        //GET api/orders/<orderId>
        [HttpGet("{orderId}")]
        public ActionResult<GetOrderModel> GetOrderById(int orderId)
        {
            Order foundOrder = _service.GetOrderById(orderId);
            if (foundOrder == null) { return NotFound(new {message = "order id not found"}); }
            return Ok(_mapper.Map<GetOrderModel>(foundOrder));
        }
        
        //POST api/orders
        [Authorize]
        [HttpPost]
        public ActionResult<GetOrderModel> PostOrder([FromBody] PostOrderModel postOrderModel)
        {
            Order order = _mapper.Map<PostOrderModel, Order>(postOrderModel);
            Order addedOrder = null;
            try
            {
                addedOrder = _service.AddOrder(order);
            }
            catch (RequestException ex)
            {
                if (ex.Code == OrderExceptionCodes.RestaurantNotFound)
                {
                    return BadRequest(new { error="make_order-01",message = "restaurant does not exist" });
                }
                if (ex.Code == OrderExceptionCodes.ProductNotFound)
                {
                    return BadRequest(new { error="make_order-02",message = "product does not exist" });
                }
                if (ex.Code == OrderExceptionCodes.BadOrderProduct)
                {
                    return BadRequest(new { error="make_order-03",message = "bad orderProduct data" });
                }
                if (ex.Code == OrderExceptionCodes.BadOrderProduct)
                {
                    return BadRequest(new { error="make-order-03",message = "bad orderProduct data" });
                }
                return BadRequest(new {message = "unknown error"});
            }
            
            return Ok(_mapper.Map<Order, GetOrderModel>(addedOrder));
        }
    }
}