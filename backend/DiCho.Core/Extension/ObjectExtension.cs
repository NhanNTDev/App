using Newtonsoft.Json;
using System.Net.Http;
using System.Text;

namespace DiCho.Core.Extension
{
    public static class ObjectExtension
    {
        public static HttpContent ToHttpContent(this object obj, JsonSerializerSettings jsonSerializerSettings)
        {
            return new StringContent(JsonConvert.SerializeObject(obj, jsonSerializerSettings), Encoding.UTF8, "application/json");
        }
    }
}
