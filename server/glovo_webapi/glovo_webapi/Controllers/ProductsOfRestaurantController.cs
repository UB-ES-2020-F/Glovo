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

        [HttpGet("{idRest}/products")]
        public ActionResult<ProductReadModel> GetAllProductsOfRestaurant(int idRest)
        {
            IEnumerable<Product> products = _service.GetAllProductsOfRestaurant(idRest);
            if (products == null || !products.Any())
            {
                return NotFound();
            }
            return Ok(_mapper.Map<IEnumerable<ProductReadModel>>(products));
        }

        [HttpGet("{idRest}/products/{idProd}")]
        public ActionResult<ProductReadModel> GetProductOfRestaurantById(int idRest, int idProd)
        {
            Product foundProduct = _service.GetProductOfRestaurantById(idRest, idProd);
            if (foundProduct == null)
            {
                return NotFound();
            }
            return Ok(_mapper.Map<ProductReadModel>(foundProduct));            
        }
    }
}