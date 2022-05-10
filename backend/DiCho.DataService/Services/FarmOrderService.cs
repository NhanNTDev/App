using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.BaseConnect;
using DiCho.Core.Custom;
using DiCho.DataService.Enums;
using DiCho.DataService.Models;
using DiCho.DataService.Repositories;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IFarmOrderService
    {
        //Task UpdateStatus(int id, string status);
        Task UpdateFarmOrderDriver(List<FarmOrderUpdateDriverInputModel> modelInput);
        Task<List<GetFarmOrderModel>> GetFarmOrder(int campaignId, int farmId);
        Task<List<GetFarmOrderModel>> GetFarmOrderByCampaign(int campaignId);
        Task<List<RevenuseOfFarmer>> GetRevenues(string from, string to);
    }

    public partial class FarmOrderService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly UserManager<AspNetUsers> _userManager;
        private readonly IFirebaseService _firebaseService;
        private readonly IFarmService _farmService;

        public FarmOrderService(IFarmOrderRepository repository, IFirebaseService firebaseService, IFarmService farmService,
            UserManager<AspNetUsers> userManager,
        IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _userManager = userManager;
            _firebaseService = firebaseService;
            _farmService = farmService;
        }

        public async Task<List<GetFarmOrderModel>> GetFarmOrder(int campaignId, int farmId)
        {
            var farmOrders = await Get(x => (x.Status == (int)FarmOrderEnum.Đãhoànthành || x.Status == (int)FarmOrderEnum.Đãhủy) && x.FarmId == farmId && x.Order.CampaignId == campaignId).ProjectTo<GetFarmOrderModel>(_mapper).ToListAsync();
            foreach (var farmOrder in farmOrders)
            {
                farmOrder.Status = farmOrder.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đã xác nhận",
                    "2" => "Đang chờ xử lý",
                    "3" => "Đang bàn giao cho bên vận chuyển",
                    "4" => "Đã bàn giao cho bên vận chuyển",
                    "5" => "Đang vận chuyển",
                    "6" => "Đã hoàn thành",
                    "7" => "Đã hủy",
                    _ => ""
                };
            }
            return farmOrders;
        }

        public async Task<List<GetFarmOrderModel>> GetFarmOrderByCampaign(int campaignId)
        {
            var farmOrders = await Get(x => x.Status == (int)FarmOrderEnum.Đãhoànthành && x.Order.CampaignId == campaignId).ProjectTo<GetFarmOrderModel>(_mapper).ToListAsync();
            foreach (var farmOrder in farmOrders)
            {
                farmOrder.Status = farmOrder.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đã xác nhận",
                    "2" => "Đang chờ xử lý",
                    "3" => "Đang bàn giao cho bên vận chuyển",
                    "4" => "Đã bàn giao cho bên vận chuyển",
                    "5" => "Đang vận chuyển",
                    "6" => "Đã hoàn thành",
                    "7" => "Đã hủy",
                    _ => ""
                };
            }
            return farmOrders;
        }

        public async Task UpdateFarmOrderDriver(List<FarmOrderUpdateDriverInputModel> modelInput)
        {
            foreach (var item in modelInput)
            {
                var farmOrders = Get(x => x.CollectionCode == item.CollectionCode).ToList();
                foreach (var farmOrder in farmOrders)
                {
                    var entity = await GetAsyn(farmOrder.Id);
                    entity.DriverId = item.DriverId;
                    await UpdateAsyn(entity);
                }
                string topic = $"{item.DriverId}";
                string title = "Đơn hàng mới cần thu gom";
                string body = $"Đơn hàng {item.CollectionCode} đang cần được thu gom.";
                await _firebaseService.SendNotification(title, body, item.DriverId.ToString(), topic);
                await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = item.DriverId, Title = title, Body = body });
            }
        }

        public async Task<List<RevenuseOfFarmer>> GetRevenues(string from, string to)
        {
            var farmers = await _userManager.Users.Where(x => x.AspNetUserRoles.Any(y => y.Role.Name == "farmer")).ProjectTo<RevenuseOfFarmer>(_mapper).ToListAsync();

            foreach (var farmer in farmers)
            {
                var farmOrders = new List<FarmOrderRevenuseModel>();
                if (from == null || to == null)
                    farmOrders = Get(x => x.Status == (int)FarmOrderEnum.Đãhoànthành && x.Farm.FarmerId == farmer.Id).ProjectTo<FarmOrderRevenuseModel>(_mapper).ToList();
                else
                    farmOrders = Get(x => x.Status == (int)FarmOrderEnum.Đãhoànthành && x.Farm.FarmerId == farmer.Id && x.CreateAt >= Convert.ToDateTime(from) && x.CreateAt <= Convert.ToDateTime(to)).ProjectTo<FarmOrderRevenuseModel>(_mapper).ToList();
                double total = 0;
                foreach (var farmOrder in farmOrders)
                {
                    farmOrder.Status = "Đã hoàn thành";
                    total += farmOrder.Total;
                }
                farmer.TotalRevenues = total;
                farmer.CountFarmOrder = farmOrders.Count;
                farmer.FarmOrders = farmOrders.OrderByDescending(x => x.CreateAt).ToList();
            }
            if (farmers.All(x => x.FarmOrders == null))
                return new List<RevenuseOfFarmer>{ };
            else
                return farmers.Where(x => x.FarmOrders.Count > 0).ToList();
        }
    }
}
