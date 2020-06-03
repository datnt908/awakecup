namespace aspnetcore.Repositories.DTOs
{
    public class AccountQueryDTO : BaseQueryDTO
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public byte[] Password { get; set; }
    }
}