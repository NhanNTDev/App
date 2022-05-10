using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class PaymentTypeModule
    {
        public static void ConfigPaymentTypeModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<PaymentType, PaymentTypeModel>();
            mc.CreateMap<PaymentTypeModel, PaymentType>();


        }
    }
}
