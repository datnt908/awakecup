namespace aspnetcore.Repositories.DTOs
{
    public class CartDetailQueryDTO : BaseQueryDTO
    {
        public int OrderID { get; set; }
        public int ProductID { get; set; }
        public int Price { get; set; }
        public int Quantity { get; set; }
        public int Total { get; set; }
    }
}