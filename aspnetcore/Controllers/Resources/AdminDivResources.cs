namespace aspnetcore.Controllers.Resources
{
    public class AdminDivSearchRequestResource : BaseFilterResource
    {
        public int? ID { get; set; }
        public int? FatherID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Level { get; set; }

        public AdminDivSearchRequestResource()
        {
            ID = null;
            FatherID = null;
            Name = string.Empty;
            Type = string.Empty;
            Level = string.Empty;
        }
    }
}