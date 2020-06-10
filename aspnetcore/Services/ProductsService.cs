using System.IO;
using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;
using System.Linq;
using System;

namespace aspnetcore.Services
{
    public interface IProductsService
    {
        (ResultCode, QueryModel) Query(ProductQueryRequest filter);
        (ResultCode, QueryModel) Search(ProductSearchRequest filter);
        (ResultCode, int?) Create(ProductCreateRequest form);
        (ResultCode, int?) Delete(int id);
        (ResultCode, int?) Update(ProductUpdateRequest form);
    }
    public class ProductsService : BaseService, IProductsService
    {
        public (ResultCode, int?) Create(ProductCreateRequest form)
        {
            if (string.IsNullOrEmpty(form.Code))
                return (ResultCode.EMPTY_PRODUCT_CODE, null);
            if (string.IsNullOrEmpty(form.Title))
                return (ResultCode.EMPTY_PRODUCT_TITLE, null);
            if (null == form.Image)
                return (ResultCode.EMPTY_PRODUCT_IMAGE, null);
            if (
                form.Code.Length > 8 ||
                form.Title.Length > 32 ||
                (null != form.Description && form.Description.Length > 1024) ||
                (Path.GetExtension(form.Image.FileName).ToLower() != ".jpg" &&
                Path.GetExtension(form.Image.FileName).ToLower() != ".png")
            )
                return (ResultCode.PRODUCT_INFO_INVALID, null);

            string fileName = string.Format("{0}_1{1}", form.Code, Path.GetExtension(form.Image.FileName));
            ResultDTO result = _procedureHelper.GetData<ResultDTO>(
                "product_table_create", new
                {
                    Code = form.Code,
                    Title = form.Title,
                    Description = form.Description,
                    CategoryID = form.CategoryID,
                    Price = form.Price,
                    ImageURL = "appdata/products/" + fileName,
                }).FirstOrDefault();
            int productID = result.Result;
            if (0 > productID)
                return ((ResultCode)Math.Abs(productID), null);

            MyFileStream fileStream = new MyFileStream();
            fileStream.ConvertFromIFormFile(form.Image);
            fileStream.FileName = fileName;
            fileStream.CreateProductImage();

            return (ResultCode.SUCCESS, productID);
        }

        public (ResultCode, int?) Delete(int id)
        {
            ResultDTO result = _procedureHelper.GetData<ResultDTO>(
                "product_table_delete", new { ID = id }).FirstOrDefault();
            int productID = result.Result;
            if (0 > productID)
                return ((ResultCode)Math.Abs(productID), null);

            ProductQueryRequest filter = new ProductQueryRequest { ID = id };
            ProductQueryDTO productDTO = _procedureHelper.GetData<ProductQueryDTO>(
                "product_table_query", filter).FirstOrDefault();
            string fileName = Path.GetFileName(productDTO.ImageURL);
            MyFileStream fileStream = new MyFileStream();
            fileStream.FileName = fileName;
            fileStream.DeleteProductImage();

            return (ResultCode.SUCCESS, productID);
        }

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

        public (ResultCode, int?) Update(ProductUpdateRequest form)
        {
            if (string.IsNullOrEmpty(form.Code))
                return (ResultCode.EMPTY_PRODUCT_CODE, null);
            if (string.IsNullOrEmpty(form.Title))
                return (ResultCode.EMPTY_PRODUCT_TITLE, null);
            if (
                form.Code.Length > 8 ||
                form.Title.Length > 32 ||
                (null != form.Description && form.Description.Length > 1024) ||
                (null != form.Image &&
                Path.GetExtension(form.Image.FileName).ToLower() != ".jpg" &&
                Path.GetExtension(form.Image.FileName).ToLower() != ".png")
            )
                return (ResultCode.PRODUCT_INFO_INVALID, null);

            ProductQueryRequest filter = new ProductQueryRequest { ID = form.ID };
            ProductQueryDTO productDTO = _procedureHelper.GetData<ProductQueryDTO>(
                "product_table_query", filter).FirstOrDefault();
            if (null == productDTO)
                return (ResultCode.PRODUCT_NOT_FOUND, null);

            string oldFileName = Path.GetFileName(productDTO.ImageURL);
            string fileName;
            if (null != form.Image)
                fileName = string.Format("{0}_1{1}", form.Code, Path.GetExtension(form.Image.FileName));
            else
                fileName = string.Format("{0}_1{1}", form.Code, Path.GetExtension(oldFileName));
            ResultDTO result = _procedureHelper.GetData<ResultDTO>(
                "product_table_update", new
                {
                    ID = form.ID,
                    Code = form.Code,
                    Title = form.Title,
                    Description = form.Description,
                    CategoryID = form.CategoryID,
                    Price = form.Price,
                    ImageURL = "appdata/products/" + fileName,
                }).FirstOrDefault();
            int productID = result.Result;
            if (0 > productID)
                return ((ResultCode)Math.Abs(productID), null);

            MyFileStream fileStream = new MyFileStream();
            fileStream.ConvertFromIFormFile(form.Image);
            fileStream.FileName = fileName;
            fileStream.UpdateProductImage(oldFileName);

            return (ResultCode.SUCCESS, productID);
        }
    }
}