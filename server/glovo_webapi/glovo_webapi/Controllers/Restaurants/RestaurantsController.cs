using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Services.Restaurants;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers
{
    [ApiController]
    [Route("api/restaurants")]
    public class RestaurantsController : ControllerBase
    {
        private readonly IRestaurantsService _service;
        private readonly IMapper _mapper;
        
        public RestaurantsController(IRestaurantsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
       
        //GET api/restaurants
        [HttpGet]
        public ActionResult<IEnumerable<RestaurantReadModel>> GetAllRestaurants()
        {
            IEnumerable<Restaurant> restaurants = _service.GetAllRestaurants();
            return Ok(_mapper.Map<IEnumerable<RestaurantReadModel>>(restaurants));
        }
        
        //GET api/restaurants/<prodId>
        [HttpGet("{prodId}")]
        public ActionResult<RestaurantReadModel> GetRestaurantById(int prodId)
        {
            Restaurant foundRestaurant = _service.GetRestaurantById(prodId);
            if (foundRestaurant == null)
            {
                return NotFound(new {message = "Restaurant id not found"});
            }
            return Ok(_mapper.Map<RestaurantReadModel>(foundRestaurant));
        }
    }
}