using System;

namespace DiCho.Core.Custom
{
    public class PropertyClass
    {
        public Type GetType(string str)
        {
            return Type.GetType("DiCho.DataService.Models." + str);
        }
    }
}
