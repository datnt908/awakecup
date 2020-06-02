namespace aspnetcore.Controllers.Resources
{
    public class OrderStatusQueryRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public string Status { get; set; }
        public OrderStatusQueryRequest()
        {
            ID = null;
        }
    }
}