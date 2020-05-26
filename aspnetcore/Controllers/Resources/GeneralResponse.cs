
using aspnetcore.Helpers;

namespace aspnetcore.Controllers.Resources
{
    public class GeneralResponse
    {
        public object Result { get; set; }
        public Result Error { get; set; }

        public GeneralResponse()
        {
            Result = null;
            Error = null;
        }
    }
}