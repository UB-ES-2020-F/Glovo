using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Services.Restaurants;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RestaurantsController : ControllerBase
    {
        private readonly IRestaurantsService _service;
        private readonly IMapper _mapper;
        
        public RestaurantsController(IRestaurantsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
        
        [HttpGet]
        public ActionResult<IEnumerable<Restaurant>> GetAllRestaurants()
        {
            IEnumerable<Restaurant> restaurants = _service.GetAllRestaurants();
            return Ok(_mapper.Map<IEnumerable<RestaurantReadModel>>(restaurants));
        }
        
        [HttpGet("{id}")]
        public ActionResult<RestaurantReadModel> GetRestaurantById(int id)
        {
            Restaurant foundRestaurant = _service.GetRestaurantById(id);
            if (foundRestaurant == null)
            {
                return NotFound();
            }
            return Ok(_mapper.Map<RestaurantReadModel>(foundRestaurant));
        }
    }
}