using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;
using Microsoft.IdentityModel.Tokens;

namespace aspnetcore.Services
{
    public interface IAccountsService
    {
        (ResultCode, QueryModel) Query(AccountQueryRequest filter);
        (ResultCode, AccountModel) Authenticate(AccountAuthenticateRequest requestBody);
    }
    public class AccountsService : BaseService, IAccountsService
    {
        public static string AuthKey { get; set; }
        public (ResultCode, AccountModel) Authenticate(AccountAuthenticateRequest body)
        {
            AccountQueryDTO accountDTO = _procedureHelper.GetData<AccountQueryDTO>(
                "account_table_get_account", new { Username = body.Username })
                .FirstOrDefault();
            if (null == accountDTO)
                return (ResultCode.ACCOUNT_NOT_FOUND, null);
            AccountModel account = new AccountModel(accountDTO);
            if (account.Password.ToLower() != body.Sha1Pass.ToLower())
                return (ResultCode.ACCOUNT_PASS_INVALID, null);

            // authentication successful so generate jwt token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(AuthKey);
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

        public (ResultCode, QueryModel) Query(AccountQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<AccountQueryDTO> accountDTOs = _procedureHelper.GetData<AccountQueryDTO>(
                "account_table_query", filter);
            if (0 != accountDTOs.Count)
                queryResult.TotalRows = accountDTOs[0].TotalRows;
            List<AccountModel> accounts = new List<AccountModel>();
            foreach (var item in accountDTOs)
            {
                AccountModel account = new AccountModel(item);
                accounts.Add(account);
            }
            queryResult.Items = accounts;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}