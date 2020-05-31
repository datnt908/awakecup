using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;
using System.Linq;
using aspnetcore.Helpers;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.Security.Claims;
using System;

namespace aspnetcore.Services
{
    public interface IAccountsService
    {
        (ResultCode, AccountModel) SignIn(string username, string sha1Pass);
    }

    public class AccountsService : BaseService, IAccountsService
    {
        public static string Secret { get; set; }
        public (ResultCode, AccountModel) SignIn(string username, string sha1Pass)
        {
            AccountModel account = new AccountModel();
            var accountDTO = procedureHelper.GetData<AccountDTO>(
                "account_signin", new { Username = username, })
                .FirstOrDefault();
            if (null == accountDTO)
                return (ResultCode.NOT_FOUND, null);
            if (BitConverter.ToString(accountDTO.Password).Replace("-", "").ToLower() != sha1Pass.ToLower())
                return (ResultCode.UN_AUTH, null);

            // authentication successful so generate jwt token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, account.ID.ToString()),
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            account.Token = tokenHandler.WriteToken(token);

            return (ResultCode.SUCCESS, account);
        }
    }
}