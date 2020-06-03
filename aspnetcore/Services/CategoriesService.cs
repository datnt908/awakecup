using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface ICategoriesService
    {
        (ResultCode, QueryModel) Query(CategoryQueryRequest filter);
    }
    public class CategoriesService : BaseService, ICategoriesService
    {
        public (ResultCode, QueryModel) Query(CategoryQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<CategoryQueryDTO> categoryDTOs = _procedureHelper.GetData<CategoryQueryDTO>(
                "category_table_query", filter);
            if (0 != categoryDTOs.Count)
                queryResult.TotalRows = categoryDTOs[0].TotalRows;
            List<CategoryModel> categories = new List<CategoryModel>();
            foreach (var item in categoryDTOs)
            {
                CategoryModel category = new CategoryModel(item);
                categories.Add(category);
            }
            queryResult.Items = categories;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}