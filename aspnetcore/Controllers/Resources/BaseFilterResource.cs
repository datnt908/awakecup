namespace aspnetcore.Controllers.Resources
{
    public class BaseFilterResource
    {
        public string Search { get; set; }
        public string Sorting { get; set; }
        public int PageNo { get; set; }
        public int PageSize { get; set; }
        public BaseFilterResource()
        {
            Search = string.Empty;
            Sorting = "ID ASC";
            PageNo = 1;
            PageSize = int.MaxValue;
        }
    }
}