using System;
using System.Threading.Tasks;

namespace DiCho.Core.BaseConnect
{
    public interface IUnitOfWork : IDisposable
    {
        int Commit();
        Task<int> CommitAsync();
    }
}
