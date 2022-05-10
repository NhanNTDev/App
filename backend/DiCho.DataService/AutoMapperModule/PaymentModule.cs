using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class PaymentModule
    {
        public static void ConfigPaymentModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Payment, PaymentModel>();
            mc.CreateMap<PaymentModel, Payment>();

            mc.CreateMap<Payment, PaymentDataMapModel>();
            mc.CreateMap<PaymentDataMapModel, Payment>();

            mc.CreateMap<Payment, PaymentOfCustomerModel>();
            mc.CreateMap<PaymentOfCustomerModel, Payment>();

        }
    }
}
