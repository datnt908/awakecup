using System;
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
        (ResultCode, QueryModel) Query(OrderQueryRequest filter);
        (ResultCode, QueryModel) Search(OrderSearchRequest filter);
        (ResultCode, string) Create(OrderCreateRequest body);

    }
    public class OrdersService : BaseService, IOrdersService
    {
        public (ResultCode, string) Create(OrderCreateRequest body)
        {
            if (0 == body.Cart.CartDetails.Count)
                return (ResultCode.EMPTY_ORDER_CART, null);
            if ("" == body.Firstname || "" == body.Lastname)
                return (ResultCode.EMPTY_ORDER_NAME, null);
            if ("" == body.Phone)
                return (ResultCode.EMPTY_ORDER_PHONE, null);
            if ("" == body.Address)
                return (ResultCode.EMPTY_ORDER_ADDR, null);
            if (
                body.Firstname.Length > 32 ||
                body.Lastname.Length > 32 ||
                body.Phone.Length > 16 ||
                body.Address.Length > 256 ||
                body.Note.Length > 256
            )
                return (ResultCode.ORDER_INFO_INVALID, null);

            ResultDTO result = _procedureHelper.GetData<ResultDTO>(
                "order_table_create", new
                {
                    Firstname = body.Firstname,
                    Lastname = body.Lastname,
                    Phone = body.Phone,
                    ProvinceID = body.ProvinceID,
                    DistrictID = body.DistrictID,
                    CommuneID = body.CommuneID,
                    Address = body.Address,
                    Note = body.Note,
                    Subtotal = body.Cart.Subtotal,
                    Delivery = body.Cart.Delivery,
                    Discount = body.Cart.Discount,
                    Total = body.Cart.Total,
                }).FirstOrDefault();
            int orderID = result.Result;
            if (0 > orderID)
                return ((ResultCode)Math.Abs(orderID), null);

            foreach (var cartDetail in body.Cart.CartDetails)
            {
                result = _procedureHelper.GetData<ResultDTO>(
                    "cart_detail_table_create", new
                    {
                        OrderID = orderID,
                        ProductID = cartDetail.ProductID,
                        Price = cartDetail.Price,
                        Quantity = cartDetail.Quantity,
                        Total = cartDetail.Total,
                    }).FirstOrDefault();
                if (0 > result.Result)
                    return ((ResultCode)Math.Abs(result.Result), null);
            }
            return (ResultCode.SUCCESS, orderID.ToString().PadLeft(10, '0'));
        }

        public (ResultCode, QueryModel) Query(OrderQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<OrderQueryDTO> orderDTOs = _procedureHelper.GetData<OrderQueryDTO>(
                "order_table_query", filter);
            if (0 != orderDTOs.Count)
                queryResult.TotalRows = orderDTOs[0].TotalRows;
            queryResult.Items = orderDTOs;
            return (ResultCode.SUCCESS, queryResult);
        }

        public (ResultCode, QueryModel) Search(OrderSearchRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<OrderSearchDTO> orderDTOs = _procedureHelper.GetData<OrderSearchDTO>(
                "order_table_search", filter);
            if (0 != orderDTOs.Count)
                queryResult.TotalRows = orderDTOs[0].TotalRows;
            List<OrderModel> orders = new List<OrderModel>();
            foreach (var item in orderDTOs)
            {
                OrderModel order = new OrderModel(item);
                orders.Add(order);
            }
            queryResult.Items = orders;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}