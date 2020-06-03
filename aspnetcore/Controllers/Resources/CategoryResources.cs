namespace aspnetcore.Controllers.Resources
{
    public class CategoryQueryRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public string Title { get; set; }
        public CategoryQueryRequest()
        {
            ID = null;
        }
    }
}