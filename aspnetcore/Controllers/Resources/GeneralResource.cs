
using aspnetcore.Helpers;

namespace aspnetcore.Controllers.Resources
{
    public class GeneralResource
    {
        public object Result { get; set; }
        public Result Error { get; set; }

        public GeneralResource()
        {
            Result = null;
            Error = null;
        }
    }
}