using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;
using glovo_webapi.Services.Products;
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

        //GET api/restaurants/<restId>/products
        [HttpGet("{restId}/products")]
        public ActionResult<ProductReadModel> GetAllProductsOfRestaurant(int restId)
        {
            IEnumerable<Product> products = _service.GetAllProductsOfRestaurant(restId);
            if (products == null || !products.Any())
            {
                return NotFound(new {message = "restaurant id not found"});
            }
            return Ok(_mapper.Map<IEnumerable<ProductReadModel>>(products));
        }

        //GET api/restaurants/<restId>/products/<prodId>
        [HttpGet("{restId}/products/{prodId}")]
        public ActionResult<ProductReadModel> GetProductOfRestaurantById(int restId, int prodId)
        {
            Product foundProduct = _service.GetProductOfRestaurantById(restId, prodId);
            if (foundProduct == null)
            {
                return NotFound(new {message = "product or restaurant id not found"});
            }
            return Ok(_mapper.Map<ProductReadModel>(foundProduct));            
        }
    }
}