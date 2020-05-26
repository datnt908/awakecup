namespace aspnetcore.Controllers.Resources
{
    public class ProductSearchRequestResource : BaseFilterResource
    {
        public int? ID { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int? CategoryID { get; set; }
        public int? Price { get; set; }
        public string ImageURL { get; set; }
        public bool? RecordStatus { get; set; }

        public ProductSearchRequestResource() {
            ID = null;
            Code = string.Empty;
            Title = string.Empty;
            Description = string.Empty;
            CategoryID = null;
            Price = null;
            ImageURL = string.Empty;
            RecordStatus = null;
        }
    }
}