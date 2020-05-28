using Microsoft.AspNetCore.Mvc;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using System.Collections.Generic;
using aspnetcore.Services.Models;
using aspnetcore.Services;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class OrdersController : ControllerBase
    {
        private IOrdersService _service = null;
        public OrdersController(IOrdersService service)
        {
            _service = service;
        }

        [HttpPost]
        [ProducesResponseType(typeof(GeneralResponse), 200)]
        [ProducesResponseType(typeof(GeneralResponse), 400)]
        [ProducesResponseType(typeof(GeneralResponse), 500)]
        public IActionResult Create([FromBody] OrderCreateResource resource)
        {
            ResultCode resultCode;
            GeneralDTO createResult;
            (resultCode, createResult) = _service.Create(resource);

            Result error;
            int statusCode;
            (statusCode, error) = ResultHandler.GetStatusCodeAndResult(resultCode);
            error.Detail = createResult.ErrorDesc;

            GeneralResponse response = new GeneralResponse
            {
                Result = createResult.Result,
                Error = error,
            };
            return StatusCode(statusCode, response);
        }
    }
}