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
    public class ProductsController : ControllerBase
    {
        private IProductsService _service = null;
        public ProductsController(IProductsService service)
        {
            _service = service;
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<ProductModel>), 200)]
        [ProducesResponseType(typeof(GeneralResponse), 500)]
        public IActionResult Search([FromQuery] ProductSearchRequestResource filter)
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