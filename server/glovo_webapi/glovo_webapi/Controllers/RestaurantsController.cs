using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Data;
using glovo_webapi.Dtos.Restaurant;
using glovo_webapi.Models;
using glovo_webapi.Services;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RestaurantsController : ControllerBase
    {
        private readonly IRestaurantsService _repository;
        private readonly IMapper _mapper;
        
        public RestaurantsController(IRestaurantsService repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        
        [HttpGet]
        public ActionResult<IEnumerable<Restaurant>> GetAllRestaurants()
        {
            IEnumerable<Restaurant> restaurants = _repository.GetAllRestaurants();
            return Ok(_mapper.Map<IEnumerable<RestaurantReadDto>>(restaurants));
        }
        
        [HttpGet("{id}")]
        public ActionResult<RestaurantReadDto> GetRestaurantById(int id)
        {
            Restaurant foundRestaurant = _repository.GetRestaurantById(id);
            if (foundRestaurant == null)
            {
                return NotFound();
            }
            return Ok(_mapper.Map<RestaurantReadDto>(foundRestaurant));
        }
    }
}