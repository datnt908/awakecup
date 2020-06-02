using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface ICartDetailsService
    {
        (ResultCode, QueryModel) Query(CartDetailQueryRequest filter);
    }
    public class CartDetailsService : BaseService, ICartDetailsService
    {
        public (ResultCode, QueryModel) Query(CartDetailQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<CartDetailQueryDTO> cartDetailDTOs = _procedureHelper.GetData<CartDetailQueryDTO>(
                "cart_detail_table_query", filter);
            if (0 != cartDetailDTOs.Count)
                queryResult.TotalRows = cartDetailDTOs[0].TotalRows;
            queryResult.Items = cartDetailDTOs;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}