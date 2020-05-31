namespace aspnetcore.Repositories.DTOs
{
    public class AccountDTO
    {
        public int TotalRows { get; set; }
        public int ID { get; set; }
        public string Username { get; set; }
        public byte[] Password { get; set; }
    }
}