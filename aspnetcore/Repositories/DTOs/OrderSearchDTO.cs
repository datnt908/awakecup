namespace aspnetcore.Repositories.DTOs
{
    public class OrderSearchDTO
    {
        public int TotalRows { get; set; }
        public int ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public int CartID { get; set; }
        public int StatusID { get; set; }
        public string Phone { get; set; }
    }
}