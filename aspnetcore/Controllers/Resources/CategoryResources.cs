namespace aspnetcore.Controllers.Resources
{
    public class CategorySearchRequestResource : BaseFilterResource
    {
        public int? ID { get; set; }
        public string Title { get; set; }

        public CategorySearchRequestResource()
        {
            ID = null;
            Title = string.Empty;
        }
    }
}