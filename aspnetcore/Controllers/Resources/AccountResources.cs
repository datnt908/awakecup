namespace aspnetcore.Controllers.Resources
{
    public class AccountSignInRequestResource
    {
        public string Username { get; set; }
        public string Sha1Pass { get; set; }
    }
}