using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.BaseConnect;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
using DiCho.DataService.Enums;
using DiCho.DataService.Models;
using DiCho.DataService.Repositories;
using DiCho.DataService.Response;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IPostService
    {
        Task<DynamicModelsResponse<PostModel>> GetPost(string customerId, PostModel model, int page, int size);
        //Task<CustomerUserModel> GetUserOfPost(string customerId);
    }

    public partial class PostService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly IJWTService _jWTService;
        private readonly UserManager<AspNetUsers> _userManager;
        private readonly IUserFollowService _userFollowService;
        private readonly ICampaignService _campaignService;

        public PostService(IPostRepository repository, IJWTService jWTService, UserManager<AspNetUsers> userManager, IUserFollowService userFollowService,
            ICampaignService campaignService, IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _jWTService = jWTService;
            _userManager = userManager;
            _userFollowService = userFollowService;
            _campaignService = campaignService;
        }

        public async Task<DynamicModelsResponse<PostModel>> GetPost(string customerId, PostModel model, int page, int size)
        {
            var customer = await _jWTService.GetUserIdOfPublish(customerId);
            if (customer.Published == null || customer.Published == false)
                return new DynamicModelsResponse<PostModel>{ Metadata = new PagingMetadata { Page = page, Size = size, Total = 0 }, Data = new List<PostModel>{ } };

            var follows = _userFollowService.Get(x => x.FollowerId == customerId).ToList();
            var followPublished = new List<string>();
            foreach (var follow in follows)
            {
                if (_jWTService.GetUserIdOfPublish(follow.FollowingId).Result.Published == true)
                    followPublished.Add(follow.FollowingId);
            }

            var resultFilter = Get(x => x.CustomerId != customerId).ProjectTo<PostModel>(_mapper)
                .DynamicFilter(model).Select<PostModel>(PostModel.Fields.ToArray().ToDynamicSelector<PostModel>()).ToList();

            var posts = new List<PostModel>();
            foreach (var user in followPublished)
                posts.AddRange(resultFilter.Where(x => x.CustomerId == user).ToList());

            foreach (var post in posts)
            {
                post.CustomerName = _jWTService.GetNameOfUser(post.CustomerId).Result;
                var campaign = _campaignService.Get(x => x.Id == post.CampaignId).FirstOrDefault();
                if (campaign.Status != (int)CampaignEnum.Đangdiễnra)
                    post.CampaignStatus = "Đã kết thúc";
                else
                    post.CampaignStatus = "Đang diễn ra";
            }
            var listPaging = posts.OrderByDescending(x => x.CreateAt).ToList().PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);

            var result = new DynamicModelsResponse<PostModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }
    }
}
