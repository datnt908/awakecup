namespace aspnetcore.Controllers.Resources
{
    public class OrderStatusSearchRequestResource : BaseFilterResource
    {
        public int? ID { get; set; }
        public string Status { get; set; }

        public OrderStatusSearchRequestResource()
        {
            ID = null;
            Status = string.Empty;
        }
    }
}