using System.Collections.Generic;
using aspnetcore.Helpers;
using aspnetcore.Services.Models;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services
{
    public interface IOrderStatusesService
    {
        (ResultCode, QueryModel) Search(object filter);
    }
    public class OrderStatusesService : BaseService, IOrderStatusesService
    {
        public (ResultCode, QueryModel) Search(object filter)
        {
            QueryModel queryResult = new QueryModel();
            List<OrderStatusDTO> orderStatusDTOs =
                procedureHelper.GetData<OrderStatusDTO>(
                    "order_status_search", filter);
            if (0 != orderStatusDTOs.Count)
                queryResult.TotalRows = orderStatusDTOs[0].TotalRows;
            List<OrderStatusModel> orderStatuses = new List<OrderStatusModel>();
            foreach (var orderStatusDTO in orderStatusDTOs)
            {
                OrderStatusModel orderStatus = new OrderStatusModel();
                orderStatus.ID = orderStatusDTO.ID;
                orderStatus.Status = orderStatusDTO.Status;
                orderStatuses.Add(orderStatus);
            }
            queryResult.Items = orderStatuses;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}