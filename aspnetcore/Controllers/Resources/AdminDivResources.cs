namespace aspnetcore.Controllers.Resources
{
    public class AdminDivQueryRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public int? FatherID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Level { get; set; }
        public AdminDivQueryRequest()
        {
            ID = null;
            FatherID = null;
        }
    }
}