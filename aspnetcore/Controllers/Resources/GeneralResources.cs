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
            Error = new Result();
        }
    }

    public class BaseQueryRequest
    {
        public string Search { get; set; }
        public string Sorting { get; set; }
        public int? PageNo { get; set; }
        public int? PageSize { get; set; }
        public BaseQueryRequest()
        {
            Search = string.Empty;
            Sorting = string.Empty;
            PageNo = null;
            PageSize = null;
        }
    }
}