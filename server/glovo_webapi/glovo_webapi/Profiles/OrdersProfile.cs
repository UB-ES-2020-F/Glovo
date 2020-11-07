using AutoMapper;
using AutoMapper.Configuration;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;

namespace glovo_webapi.Profiles
{
    public class OrdersProfile : Profile
    {
        public OrdersProfile()
        {
            CreateMap<Order, GetOrderModel>();
            CreateMap<PostOrderModel, Order>();
        }
    }
}