using Microsoft.AspNetCore.Mvc;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using System.Collections.Generic;
using aspnetcore.Services.Models;
using aspnetcore.Services;
using Microsoft.AspNetCore.Authorization;

namespace aspnetcore.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class AccountsController : ControllerBase
    {
        private IAccountsService _service = null;
        public AccountsController(IAccountsService service)
        {
            _service = service;
        }

        [HttpGet]
        [Authorize]
        [ProducesResponseType(typeof(List<AccountModel>), 200)]
        [ProducesResponseType(500)]
        public IActionResult Query([FromQuery] AccountQueryRequest filter)
        {
            ResultCode resultCode; QueryModel queryResult;
            (resultCode, queryResult) = _service.Query(filter);

            Result error; int statusCode;
            (statusCode, error) = ResultHandler.GetStatusCodeAndResult(resultCode);

            GeneralResponse response = new GeneralResponse
            {
                Result = queryResult,
                Error = error,
            };
            return StatusCode(statusCode, response);
        }

        [HttpPost]
        [ProducesResponseType(typeof(AccountModel), 200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(401)]
        [ProducesResponseType(404)]
        [ProducesResponseType(500)]
        public IActionResult Authenticate([FromBody] AccountAuthenticateRequest body)
        {
            ResultCode resultCode; AccountModel account;
            (resultCode, account) = _service.Authenticate(body);

            Result error; int statusCode;
            (statusCode, error) = ResultHandler.GetStatusCodeAndResult(resultCode);

            GeneralResponse response = new GeneralResponse
            {
                Result = account,
                Error = error,
            };
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