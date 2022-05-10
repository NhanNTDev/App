using DiCho.DataService.Commons;
using DiCho.DataService.DI;
using Microsoft.Extensions.DependencyInjection;

namespace DiCho.API.App_Start
{
    public static class DependencyInjectionResolver
    {
        public static void ConfigureDI(this IServiceCollection services)
        {
            services.InitializerDI();
            services.ConfigServiceDI();
        }
    }
}
