namespace aspnetcore.Repositories.DTOs
{
    public class CartQueryDTO : BaseQueryDTO
    {
        public int OrderID { get; set; }
        public int Subtotal { get; set; }
        public int Delivery { get; set; }
        public int Discount { get; set; }
        public int Total { get; set; }
    }
}