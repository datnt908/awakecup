namespace aspnetcore.Repositories.DTOs
{
    public class ProductQueryDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string ProductTitle { get; set; }
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public int Price { get; set; }
        public string ImageURL { get; set; }
        public bool RecordStatus { get; set; }
    }
    public class ProductSearchDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string ProductTitle { get; set; }
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public string CategoryTitle { get; set; }
        public int Price { get; set; }
        public string ImageURL { get; set; }
        public bool RecordStatus { get; set; }
    }
}