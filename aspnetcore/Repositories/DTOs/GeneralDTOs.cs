namespace aspnetcore.Repositories.DTOs
{
    public class BaseQueryDTO
    {
        public int TotalRows { get; set; }
    }

    public class ResultDTO {
        public int Result;
        public string ErrorDesc;
    }
}