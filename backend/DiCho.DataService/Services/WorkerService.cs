using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public class WorkerService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;

        public WorkerService(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }
        protected override async Task ExecuteAsync(CancellationToken cancellationToken)
        {
            while (!cancellationToken.IsCancellationRequested)
            {
                using (var scope = _serviceProvider.CreateScope())
                {
                    var _orderService = scope.ServiceProvider.GetRequiredService<IOrderService>();
                    await _orderService.StatusOrderByTime();
                    var _campaign = scope.ServiceProvider.GetRequiredService<ICampaignService>();
                    await _campaign.ChangeStatusByTimeOfCampaign();
                }
                await Task.Delay(30000, cancellationToken);
            }
        }
    }
}
