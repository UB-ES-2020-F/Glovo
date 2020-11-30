using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;
using glovo_webapi.Services;
using glovo_webapi.Services.Orders;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Orders
{
    [ApiController]
    [Route("api/users")]
    public class OrdersOfUserController : ControllerBase
    {
        private readonly IOrdersService _service;
        private readonly IMapper _mapper;
        
        public OrdersOfUserController(IOrdersService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
        
        //GET api/users/<userId>/orders
        [Authorize(Roles="Regular, Administrator")]
        [HttpGet("{userId}/orders")]
        public ActionResult<IEnumerable<GetOrderModel>> GetAllOrdersOfUser(int userId)
        {
            IEnumerable<Order> userOrders;
            try {
                userOrders = _service.GetAllOrdersOfUser(userId);
            } catch (RequestException) {
                return NotFound(new{message = "User id does not exist"});
            }
            
            //Only let Regular users see their own orders
            User loggedUser = (User)HttpContext.Items["User"];
            if (loggedUser.Role == UserRole.Regular && userId != loggedUser.Id)
                return Unauthorized(new {message = "Unauthorized"});
            
            return Ok(_mapper.Map<IEnumerable<GetOrderModel>>(userOrders));
        }
    }
}