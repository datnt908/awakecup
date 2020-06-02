namespace aspnetcore.Repositories.DTOs
{
    public class CategoryQueryDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string CategoryTitle { get; set; }
    }
}