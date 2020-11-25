using System;
using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Location;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Services.Restaurants;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Restaurants
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
        public ActionResult<IEnumerable<RestaurantModel>> GetAllRestaurants()
        {
            IEnumerable<Restaurant> restaurants = _service.GetAllRestaurants();
            return Ok(_mapper.Map<IEnumerable<RestaurantModel>>(restaurants));
        }
        
        //GET api/restaurants/<restId>
        [HttpGet("{restId}")]
        public ActionResult<RestaurantModel> GetRestaurantById(int restId)
        {
            Restaurant foundRestaurant = _service.GetRestaurantById(restId);
            if (foundRestaurant == null)
            {
                return NotFound(new {message = "Restaurant id not found"});
            }
            return Ok(_mapper.Map<RestaurantModel>(foundRestaurant));
        }
        
        //GET api/restaurants/closest
        [HttpGet("closest")]
        public ActionResult<ViewRestaurantModel> GetClosestRestaurants([FromBody]LocationModel userLocation)
        {
            IEnumerable<Restaurant> restaurants = _service.GetAllRestaurants();
            IEnumerable<ViewRestaurantModel> viewRestaurantModels =
                _mapper.Map<IEnumerable<ViewRestaurantModel>>(
                    restaurants,
                    (opts) =>
                    {
                        opts.Items["userLocation"] = userLocation;
                        opts.Items["deliveryFeeCalculator"] = new Func<double, double>((d) => { return 2.5 + (0.8 * d);});
                    });

            return Ok(viewRestaurantModels);
        } 
    }
}