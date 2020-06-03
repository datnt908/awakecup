using aspnetcore.Repositories;

namespace aspnetcore.Services
{
    public class BaseService
    {
        protected ProcedureHelper _procedureHelper;
        public BaseService()
        {
            _procedureHelper = new ProcedureHelper();
        }
    }
}