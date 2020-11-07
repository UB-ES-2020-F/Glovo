using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.OrderProduct;

namespace glovo_webapi.Profiles
{
    public class OrdersProductsProfile : Profile
    {
        public OrdersProductsProfile()
        {
            CreateMap<OrderProduct, OrderProductModel>();
            CreateMap<OrderProductModel, OrderProduct>();
        }
    }
}