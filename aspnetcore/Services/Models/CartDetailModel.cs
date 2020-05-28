namespace aspnetcore.Services.Models
{
    public class CartDetailModel
    {
        public ProductModel Product { get; set; }
        public int Price { get; set; }
        public int Quantity { get; set; }
        public int Total { get; set; }

        public CartDetailModel()
        {
            Product = new ProductModel();
        }
    }
}