using System;
using System.Text.Json.Serialization;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class AccountModel
    {
        public int ID { get; set; }
        public string Username { get; set; }
        [JsonIgnore]
        public string Password { get; set; }
        public string Token { get; set; }
        public AccountModel() { }
        public AccountModel(AccountQueryDTO dto)
        {
            ID = dto.ID;
            Username = dto.Username;
            Password = BitConverter.ToString(dto.Password).Replace("-", "");
        }

    }
}