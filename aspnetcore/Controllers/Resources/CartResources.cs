namespace aspnetcore.Controllers.Resources
{
    public class CartQueryRequest : BaseQueryRequest
    {
        public int? OrderID { get; set; }
        public int? SubtotalFrom { get; set; }
        public int? SubtotalTo { get; set; }
        public int? DeliveryFrom { get; set; }
        public int? DeliveryTo { get; set; }
        public int? DiscountFrom { get; set; }
        public int? DiscountTo { get; set; }
        public int? TotalFrom { get; set; }
        public int? TotalTo { get; set; }
        public CartQueryRequest()
        {
            OrderID = null;
            SubtotalFrom = null;
            SubtotalTo = null;
            DeliveryFrom = null;
            DeliveryTo = null;
            DiscountFrom = null;
            DiscountTo = null;
            TotalFrom = null;
            TotalTo = null;
        }
    }
}