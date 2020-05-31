using System.Collections.Generic;
using System.Linq;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface IOrdersService
    {
        (ResultCode, GeneralDTO) Create(OrderCreateResource resource);
        (ResultCode, QueryModel) Search(object filter);
    }
    public class OrderService : BaseService, IOrdersService
    {
        public (ResultCode, GeneralDTO) Create(OrderCreateResource resource)
        {
            GeneralDTO result;
            if (0 == resource.Cart.CartDetails.Count)
            {
                result = new GeneralDTO();
                result.Result = -1;
                result.ErrorDesc = "Cart and Cart detail is empty";
                return (ResultCode.CLIENT_ERR, result);
            }
            if ("" == resource.Firstname || "" == resource.Lastname)
            {
                result = new GeneralDTO();
                result.Result = -1;
                result.ErrorDesc = "Firstname or Lastname is empty";
                return (ResultCode.CLIENT_ERR, result);
            }
            if ("" == resource.Phone)
            {
                result = new GeneralDTO();
                result.Result = -1;
                result.ErrorDesc = "Guest's phone number is empty";
                return (ResultCode.CLIENT_ERR, result);
            }
            if ("" == resource.Address.Address)
            {
                result = new GeneralDTO();
                result.Result = -1;
                result.ErrorDesc = "Guest's address is empty";
                return (ResultCode.CLIENT_ERR, result);
            }
            result = procedureHelper.GetData<GeneralDTO>(
                "cart_create", new
                {
                    Subtotal = resource.Cart.Subtotal,
                    Delivery = resource.Cart.Delivery,
                    Discount = resource.Cart.Discount,
                    Total = resource.Cart.Total,
                }).FirstOrDefault();
            int cartID = result.Result;
            foreach (var cartDetail in resource.Cart.CartDetails)
            {
                result = procedureHelper.GetData<GeneralDTO>(
                    "cart_detail_create", new
                    {
                        CartID = cartID,
                        ProductID = cartDetail.ProductID,
                        Price = cartDetail.Price,
                        Quantity = cartDetail.Quantity,
                        Total = cartDetail.Total,
                    }).FirstOrDefault();
                if (-1 == result.Result)
                    return (ResultCode.CLIENT_ERR, result);
            }
            result = procedureHelper.GetData<GeneralDTO>(
                "order_create", new
                {
                    Firstname = resource.Firstname,
                    Lastname = resource.Lastname,
                    CartID = cartID,
                    StatusID = resource.StatusID,
                    Phone = resource.Phone,
                    ProvinceID = resource.Address.ProvinceID,
                    DistrictID = resource.Address.DistrictID,
                    CommuneID = resource.Address.CommuneID,
                    Address = resource.Address.Address,
                    Note = resource.Address.Note,
                }).FirstOrDefault();
            if (-1 == result.Result)
                return (ResultCode.CLIENT_ERR, result);

            return (ResultCode.SUCCESS, result);
        }

        public (ResultCode, QueryModel) Search(object filter)
        {
            List<OrderStatusModel> orderStatuses = GetAllOrderStatuses();
            QueryModel queryResult = new QueryModel();
            List<OrderSearchDTO> orderDTOs =
                procedureHelper.GetData<OrderSearchDTO>(
                    "order_search", filter);
            if (0 != orderDTOs.Count)
                queryResult.TotalRows = orderDTOs[0].TotalRows;
            List<OrderModel> orders = new List<OrderModel>();
            foreach (var orderDTO in orderDTOs)
            {
                OrderModel order = new OrderModel();
                order.ID = orderDTO.ID;
                order.Firstname = orderDTO.Firstname;
                order.Lastname = orderDTO.Lastname;
                foreach (var status in orderStatuses)
                    if (status.ID == orderDTO.StatusID)
                    {
                        order.Status = status;
                        break;
                    }
                order.Phone = orderDTO.Phone;
                order.Cart.ID = orderDTO.CartID;
                orders.Add(order);
            }
            queryResult.Items = orders;
            return (ResultCode.SUCCESS, queryResult);
        }

        private List<OrderStatusModel> GetAllOrderStatuses()
        {
            OrderStatusSearchRequestResource filter = new OrderStatusSearchRequestResource();
            List<OrderStatusDTO> orderStatusDTOs =
                procedureHelper.GetData<OrderStatusDTO>(
                    "order_status_search", filter);
            List<OrderStatusModel> orderStatuses = new List<OrderStatusModel>();
            foreach (var orderStatusDTO in orderStatusDTOs)
            {
                OrderStatusModel orderStatus = new OrderStatusModel();
                orderStatus.ID = orderStatusDTO.ID;
                orderStatus.Status = orderStatusDTO.Status;
                orderStatuses.Add(orderStatus);
            }
            return orderStatuses;
        }
    }
}