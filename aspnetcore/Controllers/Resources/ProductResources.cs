using Microsoft.AspNetCore.Http;

namespace aspnetcore.Controllers.Resources
{
    public class ProductQueryRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int? CategoryID { get; set; }
        public int? PriceFrom { get; set; }
        public int? PriceTo { get; set; }
        public string ImageURL { get; set; }
        public bool? RecordStatus { get; set; }
        public ProductQueryRequest()
        {
            ID = null;
            CategoryID = null;
            PriceFrom = null;
            PriceTo = null;
            RecordStatus = null;
        }
    }

    public class ProductSearchRequest : BaseQueryRequest
    {
        public string Code { get; set; }
        public string Title { get; set; }
        public int? CategoryID { get; set; }
        public int? PriceFrom { get; set; }
        public int? PriceTo { get; set; }
        public ProductSearchRequest()
        {
            CategoryID = null;
            PriceFrom = null;
            PriceTo = null;
        }
    }

    public class ProductCreateRequest
    {
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int? CategoryID { get; set; }
        public int? Price { get; set; }
        public IFormFile Image { get; set; }
        public ProductCreateRequest()
        {
            CategoryID = null;
            Price = null;
            Image = null;
        }
    }

    public class ProductUpdateRequest
    {
        public int? ID { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int? CategoryID { get; set; }
        public int? Price { get; set; }
        public IFormFile Image { get; set; }
        public ProductUpdateRequest()
        {
            ID = null;
            CategoryID = null;
            Price = null;
            Image = null;
        }
    }

}












