using System.Collections.Generic;

namespace aspnetcore.Controllers.Resources
{
    public class OrderCreateResource
    {
        public CartCreateResource Cart { get; set; }
        public AddressCreateResource Address { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public int? StatusID { get; set; }
        public OrderCreateResource()
        {
            Cart = null;
            Address = null;
            Firstname = string.Empty;
            Lastname = string.Empty;
            Phone = string.Empty;
            StatusID = null;
        }
    }
    public class CartCreateResource
    {
        public List<CartDetailCreateResource> CartDetails { get; set; }
        public int? Subtotal { get; set; }
        public int? Delivery { get; set; }
        public int? Discount { get; set; }
        public int? Total { get; set; }
        public CartCreateResource()
        {
            CartDetails = null;
            Subtotal = null;
            Delivery = null;
            Discount = null;
            Total = null;
        }
    }
    public class CartDetailCreateResource
    {
        public int? ProductID { get; set; }
        public int? Price { get; set; }
        public int? Quantity { get; set; }
        public int? Total { get; set; }
        public CartDetailCreateResource()
        {
            ProductID = null;
            Price = null;
            Quantity = null;
            Total = null;
        }
    }
    public class AddressCreateResource
    {
        public int? ProvinceID { get; set; }
        public int? DistrictID { get; set; }
        public int? CommuneID { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
        public AddressCreateResource()
        {
            ProvinceID = null;
            DistrictID = null;
            CommuneID = null;
            Address = string.Empty;
            Note = string.Empty;
        }
    }
}