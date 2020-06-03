namespace aspnetcore.Repositories.DTOs
{
    public class OrderQueryDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public int Price { get; set; }
        public string ImageURL { get; set; }
        public bool RecordStatus { get; set; }
    }

    public class OrderSearchDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public int StatusID { get; set; }
        public string Phone { get; set; }
        public int ProvinceID { get; set; }
        public int DistrictID { get; set; }
        public int CommuneID { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
        public int OrderID { get; set; }
        public int Subtotal { get; set; }
        public int Delivery { get; set; }
        public int Discount { get; set; }
        public int Total { get; set; }
        public string Status { get; set; }
    }
}