using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface IOrderStatusesService
    {
        (ResultCode, QueryModel) Query(OrderStatusQueryRequest filter);
    }
    public class OrderStatusesService : BaseService, IOrderStatusesService
    {
        public (ResultCode, QueryModel) Query(OrderStatusQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<OrderStatusQueryDTO> orderStatusDTOs = _procedureHelper.GetData<OrderStatusQueryDTO>(
                "order_status_table_query", filter);
            if (0 != orderStatusDTOs.Count)
                queryResult.TotalRows = orderStatusDTOs[0].TotalRows;
            List<OrderStatusModel> orderStatuses = new List<OrderStatusModel>();
            foreach (var item in orderStatusDTOs)
            {
                OrderStatusModel orderStatus = new OrderStatusModel(item);
                orderStatuses.Add(orderStatus);
            }
            queryResult.Items = orderStatuses;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}