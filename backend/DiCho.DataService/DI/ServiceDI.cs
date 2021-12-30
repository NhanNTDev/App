using DiCho.DataService.Services;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Text;

namespace DiCho.DataService.DI
{
    public static class ServiceDI
    {
        public static void ConfigServiceDI(this IServiceCollection services)
        {
            services.AddScoped<IJWTService, JWTService>();
        }
    }
}
