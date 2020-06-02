using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class OrderStatusModel
    {
        public int ID { get; set; }
        public string Status { get; set; }
        public OrderStatusModel() { }
        public OrderStatusModel(OrderStatusQueryDTO dto)
        {
            ID = dto.ID;
            Status = dto.Status;
        }
    }
}