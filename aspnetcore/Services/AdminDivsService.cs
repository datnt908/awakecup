using System.Collections.Generic;
using aspnetcore.Controllers.Resources;
using aspnetcore.Helpers;
using aspnetcore.Repositories.DTOs;
using aspnetcore.Services.Models;

namespace aspnetcore.Services
{
    public interface IAdminDivsService
    {
        (ResultCode, QueryModel) Query(AdminDivQueryRequest filter);
    }
    public class AdminDivsService : BaseService, IAdminDivsService
    {
        public (ResultCode, QueryModel) Query(AdminDivQueryRequest filter)
        {
            QueryModel queryResult = new QueryModel();
            List<AdminDivQueryDTO> adminDivDTOs = _procedureHelper.GetData<AdminDivQueryDTO>(
                "administrative_division_table_query", filter);
            if (0 != adminDivDTOs.Count)
                queryResult.TotalRows = adminDivDTOs[0].TotalRows;
            List<AdminDivModel> adminDivs = new List<AdminDivModel>();
            foreach (var item in adminDivDTOs)
            {
                AdminDivModel adminDiv = new AdminDivModel(item);
                adminDivs.Add(adminDiv);
            }
            queryResult.Items = adminDivs;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}