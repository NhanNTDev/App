
/////////////////////////////////////////////////////////////////
//
//              AUTO-GENERATED
//
/////////////////////////////////////////////////////////////////

using DiCho.DataService.Models;
using Microsoft.Extensions.DependencyInjection;
using DiCho.DataService.Services;
using DiCho.DataService.Repositories;
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
namespace DiCho.DataService.Commons
{
    public static class DependencyInjectionResolverGen
    {
        public static void InitializerDI(this IServiceCollection services)
        {
            services.AddScoped<DbContext, DiChoNaoContext>();
        
            services.AddScoped<IAddressService, AddressService>();
            services.AddScoped<IAddressRepository, AddressRepository>();
        
            services.AddScoped<IAspNetRoleService, AspNetRoleService>();
            services.AddScoped<IAspNetRoleRepository, AspNetRoleRepository>();
        
            services.AddScoped<IAspNetRoleClaimService, AspNetRoleClaimService>();
            services.AddScoped<IAspNetRoleClaimRepository, AspNetRoleClaimRepository>();
        
            services.AddScoped<IAspNetUserService, AspNetUserService>();
            services.AddScoped<IAspNetUserRepository, AspNetUserRepository>();
        
            services.AddScoped<IAspNetUserClaimService, AspNetUserClaimService>();
            services.AddScoped<IAspNetUserClaimRepository, AspNetUserClaimRepository>();
        
            services.AddScoped<IAspNetUserLoginService, AspNetUserLoginService>();
            services.AddScoped<IAspNetUserLoginRepository, AspNetUserLoginRepository>();
        
            services.AddScoped<IAspNetUserRoleService, AspNetUserRoleService>();
            services.AddScoped<IAspNetUserRoleRepository, AspNetUserRoleRepository>();
        
            services.AddScoped<IAspNetUserTokenService, AspNetUserTokenService>();
            services.AddScoped<IAspNetUserTokenRepository, AspNetUserTokenRepository>();
        
            services.AddScoped<ICampaignService, CampaignService>();
            services.AddScoped<ICampaignRepository, CampaignRepository>();
        
            services.AddScoped<ICampaignApplyService, CampaignApplyService>();
            services.AddScoped<ICampaignApplyRepository, CampaignApplyRepository>();
        
            services.AddScoped<ICampaignAreaService, CampaignAreaService>();
            services.AddScoped<ICampaignAreaRepository, CampaignAreaRepository>();
        
            services.AddScoped<ICampaignDeliveryZoneService, CampaignDeliveryZoneService>();
            services.AddScoped<ICampaignDeliveryZoneRepository, CampaignDeliveryZoneRepository>();
        
            services.AddScoped<IClusteringOrderService, ClusteringOrderService>();
            services.AddScoped<IClusteringOrderRepository, ClusteringOrderRepository>();
        
            services.AddScoped<IDeliveryZoneService, DeliveryZoneService>();
            services.AddScoped<IDeliveryZoneRepository, DeliveryZoneRepository>();
        
            services.AddScoped<IFarmService, FarmService>();
            services.AddScoped<IFarmRepository, FarmRepository>();
        
            services.AddScoped<IFarmAreaService, FarmAreaService>();
            services.AddScoped<IFarmAreaRepository, FarmAreaRepository>();
        
            services.AddScoped<IFeedbackService, FeedbackService>();
            services.AddScoped<IFeedbackRepository, FeedbackRepository>();
        
            services.AddScoped<IHarvestService, HarvestService>();
            services.AddScoped<IHarvestRepository, HarvestRepository>();
        
            services.AddScoped<IHarvestCampaignService, HarvestCampaignService>();
            services.AddScoped<IHarvestCampaignRepository, HarvestCampaignRepository>();
        
            services.AddScoped<IOrderService, OrderService>();
            services.AddScoped<IOrderRepository, OrderRepository>();
        
            services.AddScoped<IOrderItemService, OrderItemService>();
            services.AddScoped<IOrderItemRepository, OrderItemRepository>();
        
            services.AddScoped<IPaymentService, PaymentService>();
            services.AddScoped<IPaymentRepository, PaymentRepository>();
        
            services.AddScoped<IProductService, ProductService>();
            services.AddScoped<IProductRepository, ProductRepository>();
        
            services.AddScoped<IProductCategoryService, ProductCategoryService>();
            services.AddScoped<IProductCategoryRepository, ProductCategoryRepository>();
        }
    }
}
