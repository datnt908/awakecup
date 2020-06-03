using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class AdminDivModel
    {
        public int ID { get; set; }
        public int? FatherID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Level { get; set; }
        public AdminDivModel()
        {
            FatherID = null;
        }
        public AdminDivModel(AdminDivQueryDTO dto)
        {
            ID = dto.ID;
            FatherID = dto.FatherID;
            Name = dto.Name;
            Type = dto.Type;
            Level = dto.Level;
        }
    }
}