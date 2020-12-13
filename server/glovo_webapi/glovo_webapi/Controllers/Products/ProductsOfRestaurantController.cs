using System;
using System.Collections.Generic;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;
using glovo_webapi.Services;
using glovo_webapi.Services.Products;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Products
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
        public ActionResult<IEnumerable<ProductGroupModel>> GetAllProductsOfRestaurant(int idRest)
        {
            Console.Write("GET PRODUCTS");
            IEnumerable<Product> products;
            List<ProductGroup> productGroups;
            try {
                //products = _service.GetAllProductsOfRestaurant(idRest);
                productGroups = _service.GetProductsGroupOfRestaurant(idRest);
            } catch (RequestException) {
                return NotFound(new {message = "Restaurant id not found"});
            }

            List<ProductGroupModel> result = new List<ProductGroupModel>();
            foreach (var pg in productGroups)
            {
                ProductGroupModel pgm = new ProductGroupModel();
                pgm.Category = pg.Category;
                pgm.Products = _mapper.Map<IEnumerable<ProductModel>>(pg.Products);
                result.Add(pgm);
            }
            return Ok(result);
        }
    }
}
