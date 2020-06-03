namespace aspnetcore.Controllers.Resources
{
    public class AccountQueryRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public string Username { get; set; }
        public AccountQueryRequest()
        {
            ID = null;
        }
    }

    public class AccountAuthenticateRequest
    {
        public string Username { get; set; }
        public string Sha1Pass { get; set; }
    }
}