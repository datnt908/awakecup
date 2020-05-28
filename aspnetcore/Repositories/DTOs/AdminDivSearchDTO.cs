namespace aspnetcore.Repositories.DTOs
{
    public class AdminDivSearchDTO
    {
        public int TotalRows { get; set; }
        public int ID { get; set; }
        public int FatherID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Level { get; set; }
    }
}