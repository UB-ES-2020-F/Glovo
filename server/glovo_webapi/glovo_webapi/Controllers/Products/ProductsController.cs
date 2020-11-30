using System;
using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;
using glovo_webapi.Models.Restaurant;
using glovo_webapi.Services;
using glovo_webapi.Services.Products;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Products
{
    [ApiController]
    [Route("api/products")]
    public class ProductsController : ControllerBase
    {
        private readonly IProductsService _service;
        private readonly IMapper _mapper;
        
        public ProductsController(IProductsService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
        
        //GET api/products
        [HttpGet]
        public ActionResult<IEnumerable<ProductModel>> GetAllProducts([FromQuery]ProductCategory? category)
        {
            IEnumerable<Product> products;
            
            if (category.HasValue) {
                Console.Write("Category: "+category.Value+"\n");
                products = _service.GetProductsByCategory(category.Value);
            } else {
                Console.Write("Category: null\n");
                products = _service.GetAllProducts();
            }
            
            return Ok(_mapper.Map<IEnumerable<ProductModel>>(products));
        }
        
        //GET api/products/<prodId>
        [HttpGet("{prodId}")]
        public ActionResult<ProductModel> GetProductById(int prodId)
        {
            Product foundProduct;
            try {
                foundProduct = _service.GetProductById(prodId);
            } catch (RequestException) {
                return NotFound(new {message = "Product id not found"});
            }
            
            return Ok(_mapper.Map<ProductModel>(foundProduct));
        }
    }
}