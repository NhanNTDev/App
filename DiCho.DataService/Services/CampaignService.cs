using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.Custom;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
using DiCho.DataService.Enums;
using DiCho.DataService.Repositories;
using DiCho.DataService.Response;
using DiCho.DataService.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface ICampaignService
    {
        Task<DynamicModelsResponse<CampaignModel>> Gets(CampaignModel model, int page, int size);
        Task<CampaignModel> GetById(int id);
    }
    public partial class CampaignService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly ICampaignApplyService _campaignApplyService;
        public CampaignService(ICampaignRepository repository,
            ICampaignApplyService campaignApplyService,
            IMapper mapper = null) : base(repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _campaignApplyService = campaignApplyService;
        }
        public async Task<DynamicModelsResponse<CampaignModel>> Gets(CampaignModel model, int page, int size)
        {
            var result = Get().ProjectTo<CampaignModel>(_mapper)
                .DynamicFilter(model)
                .Select<CampaignModel>(CampaignModel.Fields.ToArray().ToDynamicSelector<CampaignModel>())
                .PagingIQueryable(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var campaignResult = await result.Item2.ToListAsync();
            var rs = new DynamicModelsResponse<CampaignModel>();
            foreach (var campaign in campaignResult)
            {
                var countFarmApply = await _campaignApplyService.Get(x => x.CampaignId == campaign.Id).CountAsync();
                campaign.CountFarmApply = countFarmApply;
                rs.Metadata = new PagingMetadata
                {
                    Page = page,
                    Size = size,
                    Total = result.Item1
                };
                rs.Data = campaignResult;
            }
            return rs;
        }
        public async Task<CampaignModel> GetById(int id)
        {
            var result = await Get(x => x.Id == id && x.Status == (int)CampaignEnum.OnGoing).ProjectTo<CampaignModel>(_mapper).FirstOrDefaultAsync();
            if (result == null)
            {
                throw new ErrorResponse((int)HttpStatusCode.NotFound, "Can not find");
            }
            return result;
        }
    }
}
