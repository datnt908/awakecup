namespace aspnetcore.Controllers.Resources
{
    public class CartDetailQueryRequest : BaseQueryRequest
    {
        public int? OrderID { get; set; }
        public int? ProductID { get; set; }
        public int? PriceFrom { get; set; }
        public int? PriceTo { get; set; }
        public int? QuantityFrom { get; set; }
        public int? QuantityTo { get; set; }
        public int? TotalFrom { get; set; }
        public int? TotalTo { get; set; }

        public CartDetailQueryRequest()
        {
            OrderID = null;
            ProductID = null;
            PriceFrom = null;
            PriceTo = null;
            QuantityFrom = null;
            QuantityTo = null;
            TotalFrom = null;
            TotalTo = null;
        }
    }
}