using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class CategoryModel
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public CategoryModel() { }
        public CategoryModel(CategoryQueryDTO dto)
        {
            ID = dto.ID;
            Title = dto.CategoryTitle;
        }
    }
}