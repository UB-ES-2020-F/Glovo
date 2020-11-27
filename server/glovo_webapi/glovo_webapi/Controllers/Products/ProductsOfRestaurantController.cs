using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;
using glovo_webapi.Services;
using glovo_webapi.Services.Products;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers
{
    [ApiController]
    [Route("api/restaurants")]
    public class ProductsOfRestaurantController : ControllerBase
    {
        private readonly IProductsService _service;
        private readonly IMapper _mapper;

        public ProductsOfRestaurantController(IProductsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }

        [HttpGet("{idRest}/products")]
        public ActionResult<ProductReadModel> GetAllProductsOfRestaurant(int idRest, [FromQuery]ProductCategory? category)
        {
            IEnumerable<Product> products;
            try
            {
                if (category.HasValue)
                {
                    products = _service.GetAllProductsOfRestaurantByCategory(idRest, category.Value);
                }
                else
                {
                    products = _service.GetAllProductsOfRestaurant(idRest);
                }
            }
            catch (RequestException r)
            {
                return NotFound(new {message = "restaurant id not found"});
            }
            return Ok(_mapper.Map<IEnumerable<ProductReadModel>>(products));
        }

        //GET api/restaurants/<restId>/products/<prodId>
        //TODO: this endpoint should not exists. Products have unique id regardless of restaurant.
        [HttpGet("{restId}/products/{prodId}")]
        public ActionResult<ProductReadModel> GetProductOfRestaurantById(int restId, int prodId)
        {
            Product foundProduct = _service.GetProductOfRestaurantById(restId, prodId);
            if (foundProduct == null)
            {
                return NotFound(new {message = "product not found"});
            }
            return Ok(_mapper.Map<ProductReadModel>(foundProduct));            
        }
    }
}
