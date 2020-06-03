using System.Collections.Generic;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class OrderModel
    {
        public int ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public int ProvinceID { get; set; }
        public int DistrictID { get; set; }
        public int CommuneID { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
        public OrderStatusModel Status { get; set; }
        public CartModel Cart { get; set; }
        public OrderModel()
        {
            Cart = new CartModel();
            Status = new OrderStatusModel();
        }
        public OrderModel(OrderSearchDTO dto)
        {
            ID = dto.ID;
            Firstname = dto.Firstname;
            Lastname = dto.Lastname;
            Phone = dto.Phone;
            ProvinceID = dto.ProvinceID;
            DistrictID = dto.DistrictID;
            CommuneID = dto.CommuneID;
            Address = dto.Address;
            Note = dto.Note;
            Status = new OrderStatusModel();
            Status.ID = dto.StatusID;
            Status.Status = dto.Status;
            Cart = new CartModel();
            Cart.Subtotal = dto.Subtotal;
            Cart.Delivery = dto.Delivery;
            Cart.Discount = dto.Discount;
            Cart.Total = dto.Total;
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
            }
        }
    }
}