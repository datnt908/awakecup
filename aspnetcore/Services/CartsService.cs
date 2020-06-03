using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface ICartsService
    {
        (ResultCode, QueryModel) Query(CartQueryRequest filter);
    }
    public class CartsService : BaseService, ICartsService
    {
        public (ResultCode, QueryModel) Query(CartQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<CartQueryDTO> cartDTOs = _procedureHelper.GetData<CartQueryDTO>(
                "cart_table_query", filter);
            if (0 != cartDTOs.Count)
                queryResult.TotalRows = cartDTOs[0].TotalRows;
            queryResult.Items = cartDTOs;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}