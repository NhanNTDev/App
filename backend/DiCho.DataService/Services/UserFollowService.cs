using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.BaseConnect;
using DiCho.Core.Custom;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
using DiCho.DataService.Models;
using DiCho.DataService.Repositories;
using DiCho.DataService.Response;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IUserFollowService
    {
        Task<DynamicModelsResponse<CustomerUserModel>> SuggestListUserFollow(string customerId, int page, int size);
        Task UserFollowCustomer(string customerId, string followingId);
        Task CancelFollow(string customerId, string followingId);
        int CountUserFollowCustomer(string customerId);
        int CountUserCustomerFollow(string customerId);
        Task<DynamicModelsResponse<UserFollowModel>> GetUserFollowCustomer(string customerId, int page, int size);
        Task<DynamicModelsResponse<UserFollowModel>> GetUserCustomerFollow(string customerId, int page, int size);
    }

    public partial class UserFollowService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly IJWTService _jWTService;
        private readonly UserManager<AspNetUsers> _userManager;

        public UserFollowService(IUserFollowRepository repository, IJWTService jWTService, UserManager<AspNetUsers> userManager,
            IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _jWTService = jWTService;
            _userManager = userManager;
        }

        public async Task<DynamicModelsResponse<CustomerUserModel>> SuggestListUserFollow(string customerId, int page, int size)
        {
            var customer = await _userManager.Users.Where(x => x.Id == customerId).ProjectTo<FollowModel>(_mapper).FirstOrDefaultAsync();
            var followers = customer.UserFollows;

            if (customer.ZoneId == 0 || customer.ZoneId == null)
                return new DynamicModelsResponse<CustomerUserModel> { Metadata = new PagingMetadata { Page = page, Size = size, Total = 0 }, Data = new List<CustomerUserModel> { } };
            else
            {
                var suggestCustomers = _jWTService.GetUserCustomer(customer.ZoneId, customerId).Result;
                var data = new List<CustomerUserModel>();
                foreach (var suggestCustomer in suggestCustomers)
                {
                    if (!followers.Any(x => x.FollowingId == suggestCustomer.Id))
                        data.Add(suggestCustomer);
                }

                var listPaging = data.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);

                var result = new DynamicModelsResponse<CustomerUserModel>
                {
                    Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                    Data = listPaging.Item2
                };
                return result;
            }
        }

        public async Task UserFollowCustomer(string customerId, string followingId)
        {
            if (Get(x => x.FollowerId == customerId && x.FollowingId == followingId).Any())
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Đã theo dõi!");
            var following = await _jWTService.GetUserId(followingId);
            var follower = _jWTService.GetUserId(customerId).Result;
            var model = new UserFollowCreateModel
            {
                FollowerId = customerId,
                FollowerName = follower.Name,
                FollowerImage = follower.Image,
                FollowingId = followingId,
                FollowingName = following.Name,
                FollowingImage = following.Image
            };
            var entity = _mapper.CreateMapper().Map<UserFollow>(model);
            await CreateAsyn(entity);
        }

        public async Task<DynamicModelsResponse<UserFollowModel>> GetUserFollowCustomer(string customerId, int page, int size)
        {
            var users = await Get(x => x.FollowingId == customerId).ProjectTo<UserFollowModel>(_mapper).ToListAsync();
            var listPaging = users.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);

            var result = new DynamicModelsResponse<UserFollowModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public async Task<DynamicModelsResponse<UserFollowModel>> GetUserCustomerFollow(string customerId, int page, int size)
        {
            var users = await Get(x => x.FollowerId == customerId).ProjectTo<UserFollowModel>(_mapper).ToListAsync();
            var listPaging = users.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);

            var result = new DynamicModelsResponse<UserFollowModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public int CountUserFollowCustomer(string customerId)
        {
            var users = Get(x => x.FollowingId == customerId).Count();
            return users;
        }
        
        public int CountUserCustomerFollow(string customerId)
        {
            var users = Get(x => x.FollowerId == customerId).Count();
            return users;
        }

        public async Task CancelFollow(string customerId, string followingId)
        {
            var entity = Get(x => x.FollowerId == customerId && x.FollowingId == followingId).FirstOrDefault();
            if (entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy");
            await DeleteAsyn(entity);
        }
        
    }
}
