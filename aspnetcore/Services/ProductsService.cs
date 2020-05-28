using System.Collections.Generic;
using aspnetcore.Helpers;
using aspnetcore.Services.Models;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Controllers.Resources;

namespace aspnetcore.Services
{
    public interface IProductsService
    {
        (ResultCode, QueryModel) Search(object filter);
    }
    public class ProductsService : BaseService, IProductsService
    {
        public (ResultCode, QueryModel) Search(object filter)
        {
            List<CategoryModel> categories = GetAllCategories();
            QueryModel queryResult = new QueryModel();
            List<ProductSearchDTO> productDTOs =
                procedureHelper.GetData<ProductSearchDTO>(
                    "product_search", filter);
            if (0 != productDTOs.Count)
                queryResult.TotalRows = productDTOs[0].TotalRows;
            List<ProductModel> products = new List<ProductModel>();
            foreach (var productDTO in productDTOs)
            {
                ProductModel product = new ProductModel();
                product.ID = productDTO.ID;
                product.Code = productDTO.Code;
                product.Title = productDTO.Title;
                product.Description = productDTO.Description;
                foreach (var category in categories)
                    if (category.ID == productDTO.CategoryID)
                    {
                        product.Category = category;
                        break;
                    }
                product.Price = productDTO.Price;
                product.ImageURL = FileHandler.GetFileUrl(
                    PrefixPaths.PRODUCTS, productDTO.ImageURL);
                product.RecordStatus = productDTO.RecordStatus;
                products.Add(product);
            }
            queryResult.Items = products;
            return (ResultCode.SUCCESS, queryResult);
        }

        private List<CategoryModel> GetAllCategories()
        {
            CategorySearchRequestResource filter = new CategorySearchRequestResource();
            List<CategorySearchDTO> categoryDTOs =
                procedureHelper.GetData<CategorySearchDTO>(
                    "category_search", filter);
            List<CategoryModel> categories = new List<CategoryModel>();
            foreach (var categoryDTO in categoryDTOs)
            {
                CategoryModel category = new CategoryModel();
                category.ID = categoryDTO.ID;
                category.Title = categoryDTO.Title;
                categories.Add(category);
            }
            return categories;
        }
    }
}