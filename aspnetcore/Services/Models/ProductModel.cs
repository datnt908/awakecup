using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services.Models
{
    public class ProductModel
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public CategoryModel Category { get; set; }
        public int Price { get; set; }
        public string ImageURL { get; set; }
        public bool RecordStatus { get; set; }
        public ProductModel()
        {
            Category = new CategoryModel();
        }
        public ProductModel(ProductSearchDTO dto)
        {
            ID = dto.ID;
            Code = dto.Code;
            Title = dto.ProductTitle;
            Description = dto.Description;
            Category = new CategoryModel
            {
                ID = dto.CategoryID,
                Title = dto.CategoryTitle,
            };
            Price = dto.Price;
            ImageURL = dto.ImageURL;
            RecordStatus = dto.RecordStatus;
        }
    }
}