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
    public class CategoriesController : ControllerBase
    {
        private ICategoriesService _service = null;
        public CategoriesController(ICategoriesService service)
        {
            _service = service;
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<CategoryModel>), 200)]
        [ProducesResponseType(typeof(GeneralResponse), 500)]
        public IActionResult Search([FromQuery] CategorySearchRequestResource filter)
        {
            ResultCode resultCode;
            QueryModel queryResult;
            (resultCode, queryResult) = _service.Search(filter);

            Result error;
            int statusCode;
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