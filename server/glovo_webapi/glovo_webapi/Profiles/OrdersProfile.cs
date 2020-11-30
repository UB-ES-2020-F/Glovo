using System;
using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Models.Order;

namespace glovo_webapi.Profiles
{
    public class OrdersProfile : Profile
    {
        public OrdersProfile()
        {
            CreateMap<Order, GetOrderModel>()
                .ForMember(getOrderModel => getOrderModel.Products,
                    opts => 
                        opts.MapFrom(order => order.OrdersProducts));
            CreateMap<PostOrderModel, Order>()
                .ForMember(order => order.OrdersProducts,
                    opts =>
                        opts.MapFrom(postOrderModel => postOrderModel.Products))
                .ForMember(order => order.BuyDateTime,
                    opts =>
                        opts.MapFrom(postOrderModel => DateTime.UtcNow));
        }       
    }
}