using Microsoft.AspNetCore.Mvc;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using System.Collections.Generic;
using aspnetcore.Services.Models;
using aspnetcore.Services;

namespace aspnetcore.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class AdminDivsController : ControllerBase
    {
        private IAdminDivsService _service = null;
        public AdminDivsController(IAdminDivsService service)
        {
            _service = service;
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<AdminDivModel>), 200)]
        [ProducesResponseType(500)]
        public IActionResult Query([FromQuery] AdminDivQueryRequest filter)
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
    }
}