using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;
using glovo_webapi.Services;
using glovo_webapi.Services.Orders;
using glovo_webapi.Services.UserService;
using Microsoft.AspNetCore.Mvc;
using glovo_webapi.Helpers;
using glovo_webapi.Utils;

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
        [Authorize(Roles="Administrator")]
        public ActionResult<IEnumerable<GetOrderModel>> GetAllOrders()
        {
            IEnumerable<Order> orders = _service.GetAllOrders();
            return Ok(_mapper.Map<IEnumerable<GetOrderModel>>(orders));
        }
        
        //GET api/orders/<orderId>
        [HttpGet("{orderId}")]
        [Authorize(Roles="Regular, Administrator")]
        public ActionResult<GetOrderModel> GetOrderById(int orderId)
        {
            Order foundOrder;
            try {
                foundOrder = _service.GetOrderById(orderId);
            } catch(RequestException) {
                return NotFound(new {message = "Order id not found"});
            }
            
            //Only let Regular users check their own orders
            User loggedUser = (User)HttpContext.Items["User"];
            if (loggedUser.Role == UserRole.Regular && foundOrder.UserId != loggedUser.Id)
                return Unauthorized(new {message = "Unauthorized"});

            return Ok(_mapper.Map<GetOrderModel>(foundOrder));
        }
        
        //POST api/orders
        [Authorize(Roles="Regular, Administrator")]
        [HttpPost]
        public ActionResult<GetOrderModel> PostOrder([FromBody] PostOrderModel postOrderModel)
        {
            Order order = _mapper.Map<PostOrderModel, Order>(postOrderModel);
            Order addedOrder;
            try {
                addedOrder = _service.AddOrder(order);
            } catch (RequestException ex) {
                if (ex.Code == OrderExceptionCodes.RestaurantNotFound)
                    return NotFound(new{message = "Restaurant id does not exist"});
                if (ex.Code == OrderExceptionCodes.ProductNotFound)
                    return NotFound(new{message = "Product id does not exist"});
                if (ex.Code == OrderExceptionCodes.BadOrderProduct)
                    return BadRequest(new{message = "Bad OrderProduct data"});
                return BadRequest(new{message = "Unknown error"});
            }
            
            return Ok(_mapper.Map<Order, GetOrderModel>(addedOrder));
        }
    }
}