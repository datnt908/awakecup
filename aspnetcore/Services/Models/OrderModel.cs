using System.Collections.Generic;
using System.Linq;
using aspnetcore.Controllers.Resources;
using aspnetcore.Repositories;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class OrderModel
    {
        public string ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public string Province { get; set; }
        public string District { get; set; }
        public string Commune { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
        public OrderStatusModel Status { get; set; }
        public CartModel Cart { get; set; }
        public OrderModel()
        {
            Cart = new CartModel();
            Status = new OrderStatusModel();
        }
        public OrderModel(OrderSearchDTO order, List<CartDetailSearchDTO> cartDetails)
        {
            ID = order.ID.ToString().PadLeft(10, '0');
            Firstname = order.Firstname;
            Lastname = order.Lastname;
            Phone = order.Phone;
            ProcedureHelper procedureHelper = new ProcedureHelper();
            AdminDivQueryDTO provinceDTO = procedureHelper.GetData<AdminDivQueryDTO>(
                "administrative_division_table_query", new AdminDivQueryRequest { ID = order.ProvinceID })
                .FirstOrDefault();
            Province = provinceDTO.Name;
            AdminDivQueryDTO districtDTO = procedureHelper.GetData<AdminDivQueryDTO>(
               "administrative_division_table_query", new AdminDivQueryRequest { ID = order.DistrictID })
               .FirstOrDefault();
            District = districtDTO.Name;
            AdminDivQueryDTO communeDTO = procedureHelper.GetData<AdminDivQueryDTO>(
               "administrative_division_table_query", new AdminDivQueryRequest { ID = order.CommuneID })
               .FirstOrDefault();
            Commune = communeDTO.Name;
            Address = order.Address;
            Note = order.Note;
            Status = new OrderStatusModel();
            Status.ID = order.StatusID;
            Status.Status = order.Status;
            Cart = new CartModel();
            Cart.Subtotal = order.Subtotal;
            Cart.Delivery = order.Delivery;
            Cart.Discount = order.Discount;
            Cart.Total = order.Total;
            for (int i = 0; i < cartDetails.Count; i++)
            {
                CartModel.CartDetailModel cartDetail =
                    new CartModel.CartDetailModel(cartDetails[i]);
                Cart.CartDetails.Add(cartDetail);
            }
        }
        public class CartModel
        {
            public int Subtotal { get; set; }
            public int Delivery { get; set; }
            public int Discount { get; set; }
            public int Total { get; set; }
            public List<CartDetailModel> CartDetails { get; set; }
            public CartModel()
            {
                CartDetails = new List<CartDetailModel>();
            }
            public class CartDetailModel
            {
                public ProductModel Product { get; set; }
                public int Price { get; set; }
                public int Quantity { get; set; }
                public int Total { get; set; }
                public CartDetailModel()
                {
                    Product = new ProductModel();
                }
                public CartDetailModel(CartDetailSearchDTO dto)
                {
                    Product = new ProductModel();
                    Product.Code = dto.Code;
                    Product.Title = dto.ProductTitle;
                    Product.Category = new CategoryModel();
                    Product.Category.Title = dto.CategoryTitle;
                    Price = dto.Price;
                    Quantity = dto.Quantity;
                    Total = dto.Total;
                }
            }
        }
    }
}