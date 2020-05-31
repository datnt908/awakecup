using System.Text.Json.Serialization;

namespace aspnetcore.Services.Models
{
    public class AccountModel
    {
        public int ID { get; set; }
        public string Username { get; set; }
        [JsonIgnore]
        public string Password { get; set; }
        public string Token { get; set; }
    }
}