using aspnetcore.Services;
using Microsoft.AspNetCore.Mvc;
using aspnetcore.Controllers.Resources;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using aspnetcore.Services.Models;
using aspnetcore.Helpers;

namespace aspnetcore.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class AccountsController : ControllerBase
    {
        private readonly IAccountsService _service;
        public AccountsController(IAccountsService service)
        {
            _service = service;
        }

        [HttpPost]
        [ProducesResponseType(typeof(AccountModel), 200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(typeof(GeneralResponse), 401)]
        [ProducesResponseType(typeof(GeneralResponse), 404)]
        [ProducesResponseType(typeof(GeneralResponse), 500)]
        public IActionResult SignIn(
            [FromBody] AccountSignInRequestResource userAccount)
        {
            ResultCode resultCode;
            AccountModel account = null;
            (resultCode, account) = _service.SignIn(
                userAccount.Username, userAccount.Sha1Pass);

            Result resultValue; int statusCode;
            (statusCode, resultValue) = ResultHandler.GetStatusCodeAndResult(resultCode);
            GeneralResponse response = new GeneralResponse()
            {
                Error = resultValue,
            };

            if (ResultCode.NOT_FOUND == resultCode)
                response.Error.Detail = "Invalid Username";

            if (ResultCode.UN_AUTH == resultCode)
                response.Error.Detail = "Invalid Password";

            response.Result = account;
            return StatusCode(statusCode, response);
        }
        [HttpGet]
        [Authorize]
        [ProducesResponseType(200)]
        [ProducesResponseType(401)]
        public IActionResult CheckAuth()
        {
            return StatusCode(200);
        }
    }
}