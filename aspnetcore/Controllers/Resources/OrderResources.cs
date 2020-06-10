using System.Collections.Generic;

namespace aspnetcore.Controllers.Resources
{
    public class OrderQueryRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public int? StatusID { get; set; }
        public string Phone { get; set; }
        public int? ProvinceID { get; set; }
        public int? DistrictID { get; set; }
        public int? CommuneID { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
        public OrderQueryRequest()
        {
            ID = null;
            StatusID = null;
            ProvinceID = null;
            DistrictID = null;
            CommuneID = null;
        }
    }

    public class OrderCreateRequest
    {
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public int? ProvinceID { get; set; }
        public int? DistrictID { get; set; }
        public int? CommuneID { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
        public CartCreateRequest Cart { get; set; }
        public OrderCreateRequest()
        {
            ProvinceID = null;
            DistrictID = null;
            CommuneID = null;
            Cart = new CartCreateRequest();
        }
        public class CartCreateRequest
        {
            public int? Subtotal { get; set; }
            public int? Delivery { get; set; }
            public int? Discount { get; set; }
            public int? Total { get; set; }
            public List<CartDetailCreateRequest> CartDetails { get; set; }
            public CartCreateRequest()
            {
                Subtotal = null;
                Delivery = null;
                Discount = null;
                Total = null;
            }
            public class CartDetailCreateRequest
            {
                public int? ProductID { get; set; }
                public int? Price { get; set; }
                public int? Quantity { get; set; }
                public int? Total { get; set; }
            }
        }
    }

    public class OrderSearchRequest : BaseQueryRequest
    {
        public int? ID { get; set; }
        public string Fullname { get; set; }
        public string Phone { get; set; }
        public int? StatusID { get; set; }
        public int? TotalFrom { get; set; }
        public int? TotalTo { get; set; }
        public OrderSearchRequest()
        {
            StatusID = null;
            TotalFrom = null;
            TotalTo = null;
        }
    }

    public class OrderUpdateStatusRequest
    {
        public int? ID { get; set; }
        public int? StatusID { get; set; }
    }
}