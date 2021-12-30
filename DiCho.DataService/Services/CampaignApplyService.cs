using AutoMapper;
using AutoMapper.QueryableExtensions;
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
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface ICampaignApplyService
    {
        Task<DynamicModelsResponse<CampaignApplyModel>> Gets(CampaignApplyModel model, int page, int size);
    }
    public partial class CampaignApplyService
    {
        private readonly IConfigurationProvider _mapper;
        public CampaignApplyService(ICampaignApplyRepository repository, IMapper mapper = null) : base(repository)
        {
            _mapper = mapper.ConfigurationProvider;
        }
        public async Task<DynamicModelsResponse<CampaignApplyModel>> Gets(CampaignApplyModel model, int page, int size)
        {
            var result = Get(x => x.Status == (int)CampaignApplyEnum.Accept).ProjectTo<CampaignApplyModel>(_mapper)
                .DynamicFilter(model)
                .Select<CampaignApplyModel>(CampaignApplyModel.Fields.ToArray().ToDynamicSelector<CampaignApplyModel>())
                .PagingIQueryable(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var rs = new DynamicModelsResponse<CampaignApplyModel>
            {
                Metadata = new PagingMetadata
                {
                    Page = page,
                    Size = size,
                    Total = result.Item1
                },
                Data = await result.Item2.ToListAsync()
            };
            return rs;
        }

    }
}
