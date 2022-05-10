using System;
using System.Collections.Generic;

namespace DiCho.DataService.Response
{
    [Serializable]
    public class DynamicModelsResponse<T>
    {
        public PagingMetadata Metadata { get; set; }
        public List<T> Data { get; set; }
    }
    public class PagingMetadata
    {
        public int Page { get; set; }
        public int Size { get; set; }
        public int Total { get; set; }
    }
}
