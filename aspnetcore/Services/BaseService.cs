using aspnetcore.Repositories;

namespace aspnetcore.Services
{
    public class BaseService
    {
        protected ProcedureHelper procedureHelper = null;
        public BaseService()
        {
            procedureHelper = new ProcedureHelper();
        }
    }
}