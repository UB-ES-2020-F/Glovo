using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Product;

namespace glovo_webapi.Profiles
{
    public class ProductsProfile : Profile
    {
        public ProductsProfile()
        {
            CreateMap<Product, ProductReadModel>();
        }
    }
}