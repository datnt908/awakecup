using System.Collections.Generic;
using aspnetcore.Helpers;
using aspnetcore.Services.Models;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services
{
    public interface ICategoriesService
    {
        (ResultCode, QueryModel) Search(object filter);
    }
    public class CategoriesService : BaseService, ICategoriesService
    {
        public (ResultCode, QueryModel) Search(object filter)
        {
            QueryModel queryResult = new QueryModel();
            List<CategorySearchDTO> categoryDTOs = procedureHelper.GetData<CategorySearchDTO>("category_search", filter);
            if (0 != categoryDTOs.Count)
                queryResult.TotalRows = categoryDTOs[0].TotalRows;
            List<CategoryModel> categories = new List<CategoryModel>();
            foreach (var categoryDTO in categoryDTOs)
            {
                CategoryModel category = new CategoryModel();
                category.ID = categoryDTO.ID;
                category.Title = categoryDTO.Title;
                categories.Add(category);
            }
            queryResult.Items = categories;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}