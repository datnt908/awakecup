namespace aspnetcore.Repositories.DTOs
{
    public class OrderStatusQueryDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string Status { get; set; }
    }
}