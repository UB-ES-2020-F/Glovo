using System.Collections.Generic;
using glovo_webapi.Data;
using glovo_webapi.Models;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers
{
    [ApiController]
    [Route("api/[controller]s")]
    public class RestaurantController : ControllerBase
    {
        private readonly MockRestaurantRepo _repository = new MockRestaurantRepo();
        
        [HttpGet]
        public ActionResult<IEnumerable<Restaurant>> GetAllRestaurants()
        {
            return Ok(_repository.GetAllRestaurants());
        }
        
        [HttpGet("{id}")]
        public ActionResult<Restaurant> GetRestaurantById(int id)
        {
            return Ok(_repository.GetRestaurantById(id));
        }
    }
}