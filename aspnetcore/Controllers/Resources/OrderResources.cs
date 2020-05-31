namespace aspnetcore.Controllers.Resources
{
    public class OrderSearchRequestResource : BaseFilterResource
    {
        public int? ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public int? StatusID { get; set; }
        public string Phone { get; set; }

        public OrderSearchRequestResource()
        {
            ID = null;
            Firstname = string.Empty;
            Lastname = string.Empty;
            StatusID = null;
            Phone = string.Empty;
        }
    }
}