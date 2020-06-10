using Microsoft.AspNetCore.Mvc;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using System.Collections.Generic;
using aspnetcore.Services.Models;
using aspnetcore.Services;
using aspnetcore.Repositories.DTOs;
using Microsoft.AspNetCore.Authorization;

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
        [ProducesResponseType(typeof(List<ProductQueryDTO>), 200)]
        [ProducesResponseType(500)]
        public IActionResult Query([FromQuery] ProductQueryRequest filter)
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

        [HttpGet]
        [ProducesResponseType(typeof(List<ProductModel>), 200)]
        [ProducesResponseType(500)]
        public IActionResult Search([FromQuery] ProductSearchRequest filter)
        {
            ResultCode resultCode; QueryModel queryResult;
            (resultCode, queryResult) = _service.Search(filter);

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
        [Authorize]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(401)]
        [ProducesResponseType(404)]
        [ProducesResponseType(500)]
        public IActionResult Create([FromForm] ProductCreateRequest form)
        {
            ResultCode resultCode; int? productID;
            (resultCode, productID) = _service.Create(form);

            Result error; int statusCode;
            (statusCode, error) = ResultHandler.GetStatusCodeAndResult(resultCode);

            GeneralResponse response = new GeneralResponse
            {
                Result = productID,
                Error = error,
            };
            return StatusCode(statusCode, response);
        }

        [HttpDelete]
        [Authorize]
        [ProducesResponseType(200)]
        [ProducesResponseType(401)]
        [ProducesResponseType(404)]
        [ProducesResponseType(500)]
        public IActionResult Delete([FromQuery] int id)
        {
            ResultCode resultCode; int? productID;
            (resultCode, productID) = _service.Delete(id);

            Result error; int statusCode;
            (statusCode, error) = ResultHandler.GetStatusCodeAndResult(resultCode);

            GeneralResponse response = new GeneralResponse
            {
                Result = productID,
                Error = error,
            };
            return StatusCode(statusCode, response);
        }

        [HttpPut]
        [Authorize]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(401)]
        [ProducesResponseType(404)]
        [ProducesResponseType(500)]
        public IActionResult Update([FromForm] ProductUpdateRequest form)
        {
            ResultCode resultCode; int? productID;
            (resultCode, productID) = _service.Update(form);

            Result error; int statusCode;
            (statusCode, error) = ResultHandler.GetStatusCodeAndResult(resultCode);

            GeneralResponse response = new GeneralResponse
            {
                Result = productID,
                Error = error,
            };
            return StatusCode(statusCode, response);
        }

    }
}