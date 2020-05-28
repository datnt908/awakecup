namespace aspnetcore.Repositories.DTOs
{
    public class ProductSearchDTO
    {
        public int TotalRows { get; set; }
        public int ID { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public int Price { get; set; }
        public string ImageURL { get; set; }
        public bool RecordStatus { get; set; }
    }
}