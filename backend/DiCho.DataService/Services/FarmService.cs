using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.Custom;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
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
    public partial interface IFarmService
    {
        Task<DynamicModelsResponse<FarmModel>> Gets(FarmModel model, int page, int size);
        Task<FarmModel> GetById(int id);
    }
    public partial class FarmService
    {
        private readonly IConfigurationProvider _mapper;
        public FarmService(IFarmRepository repository, IMapper mapper = null) : base(repository)
        {
            _mapper = mapper.ConfigurationProvider;
        }

        public async Task<DynamicModelsResponse<FarmModel>> Gets(FarmModel model, int page, int size)
        {
            var result = Get().ProjectTo<FarmModel>(_mapper)
                .DynamicFilter(model)
                .Select<FarmModel>(FarmModel.Fields.ToArray().ToDynamicSelector<FarmModel>())
                .PagingIQueryable(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var rs = new DynamicModelsResponse<FarmModel>
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

        public async Task<FarmModel> GetById(int id)
        {
            var result = await Get(x => x.Id == id).ProjectTo<FarmModel>(_mapper).FirstOrDefaultAsync();
            if (result == null)
            {
                throw new ErrorResponse((int)HttpStatusCode.NotFound, "Can not find");
            }
            return result;
        }
    }
}
