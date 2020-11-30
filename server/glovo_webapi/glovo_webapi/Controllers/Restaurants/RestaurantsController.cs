using System;
using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Location;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Services;
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
        public ActionResult<IEnumerable<LocationRestaurantModel>> GetAllRestaurants()
        {
            IEnumerable<Restaurant> restaurants = _service.GetAllRestaurants();
            return Ok(_mapper.Map<IEnumerable<LocationRestaurantModel>>(restaurants));
        }
        
        //GET api/restaurants/<restId>
        [HttpGet("{restId}")]
        public ActionResult<LocationRestaurantModel> GetRestaurantById(int restId)
        {
            Restaurant foundRestaurant;
            try {
                foundRestaurant = _service.GetRestaurantById(restId);
            } catch (RequestException) {
                return NotFound(new {message = "Restaurant id not found"});
            }
            
            return Ok(_mapper.Map<LocationRestaurantModel>(foundRestaurant));
        }
        
        //GET api/restaurants/closest
        [HttpGet("closest")]
        public ActionResult<DistanceRestaurantModel> GetClosestRestaurants([FromQuery]LocationModel userLocation)
        {
            IEnumerable<Restaurant> restaurants = _service.GetAllRestaurants();
            IEnumerable<DistanceRestaurantModel> viewRestaurantModels =
                _mapper.Map<IEnumerable<DistanceRestaurantModel>>(
                    restaurants,
                    opts =>
                    {
                        opts.Items["userLocation"] = _mapper.Map<Location>(userLocation);
                        opts.Items["deliveryFeeCalculator"] = new Func<double, double>(d => { return 2.5 + 0.8 * d;});
                    });

            viewRestaurantModels =
                ((List<DistanceRestaurantModel>) viewRestaurantModels).OrderBy(vrm => vrm.Distance);
            
            return Ok(viewRestaurantModels);
        } 
    }
}