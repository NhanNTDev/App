﻿using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace DiCho.Core.Extension
{
    public static class MigrationExtension
    {
        public static void ConfigMigration<TDbContext>(this IApplicationBuilder app) where TDbContext : DbContext
        {
            try
            {
                using var serviceScope = app.ApplicationServices.GetRequiredService<IServiceScopeFactory>()
                    .CreateScope();

                serviceScope.ServiceProvider.GetService<TDbContext>().Database.Migrate();
            }
            catch (Exception ex)
            {
                //do nothing
                Console.WriteLine(ex.StackTrace);
            }
        }
    }
}
