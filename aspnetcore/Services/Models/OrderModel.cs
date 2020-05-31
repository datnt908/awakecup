namespace aspnetcore.Services.Models
{
    public class OrderModel
    {
        public int ID { get; set; }
        public CartModel Cart { get; set; }
        public AddressModel Address { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public OrderStatusModel Status { get; set; }
        public OrderModel()
        {
            Cart = new CartModel();
            Address = new AddressModel();
            Status = new OrderStatusModel();
        }
    }
}