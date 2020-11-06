using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;
using glovo_webapi.Services.Products;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly IProductsService _service;
        private readonly IMapper _mapper;
        
        public ProductsController(IProductsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
        
        [HttpGet]
        public ActionResult<IEnumerable<ProductReadModel>> GetAllProducts(ProductCategory? category)
        {
            IEnumerable<Product> products;
            if (category.HasValue)
            {
                products = _service.GetProductsByCategory(category.Value);
            }
            else
            {
                products = _service.GetAllProducts();
            }
            return Ok(_mapper.Map<IEnumerable<ProductReadModel>>(products));
        }
        
        [HttpGet("{id}")]
        public ActionResult<ProductReadModel> GetProductById(int id)
        {
            Product foundProduct = _service.GetProductById(id);
            if (foundProduct == null)
            {
                return NotFound(new {message = "product id not found"});
            }
            return Ok(_mapper.Map<ProductReadModel>(foundProduct));
        }
    }
}