using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface IProductsService
    {
        (ResultCode, QueryModel) Query(ProductQueryRequest filter);
        (ResultCode, QueryModel) Search(ProductSearchRequest filter);
    }
    public class ProductsService : BaseService, IProductsService
    {
        public (ResultCode, QueryModel) Query(ProductQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<ProductQueryDTO> productDTOs = _procedureHelper.GetData<ProductQueryDTO>(
                "product_table_query", filter);
            if (0 != productDTOs.Count)
                queryResult.TotalRows = productDTOs[0].TotalRows;
            queryResult.Items = productDTOs;
            return (ResultCode.SUCCESS, queryResult);
        }

        public (ResultCode, QueryModel) Search(ProductSearchRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<ProductSearchDTO> productDTOs = _procedureHelper.GetData<ProductSearchDTO>(
                "product_table_search", filter);
            if (0 != productDTOs.Count)
                queryResult.TotalRows = productDTOs[0].TotalRows;
            List<ProductModel> products = new List<ProductModel>();
            foreach (var item in productDTOs)
            {
                ProductModel product = new ProductModel(item);
                products.Add(product);
            }
            queryResult.Items = products;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}