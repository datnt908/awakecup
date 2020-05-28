using System.Collections.Generic;

namespace aspnetcore.Services.Models
{
    public class CartModel
    {
        public List<CartDetailModel> CartDetails { get; set; }
        public int Subtotal { get; set; }
        public int Delivery { get; set; }
        public int Discount { get; set; }
        public int Total { get; set; }
        public CartModel()
        {
            CartDetails = new List<CartDetailModel>();
        }
    }
}