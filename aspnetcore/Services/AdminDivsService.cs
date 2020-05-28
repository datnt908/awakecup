using System.Collections.Generic;
using aspnetcore.Helpers;
using aspnetcore.Services.Models;
using aspnetcore.Repositories.DTOs;

namespace aspnetcore.Services
{
    public interface IAdminDivsService
    {
        (ResultCode, QueryModel) Search(object filter);
    }
    public class AdminDivsService : BaseService, IAdminDivsService
    {
        public (ResultCode, QueryModel) Search(object filter)
        {
            QueryModel queryResult = new QueryModel();
            List<AdminDivSearchDTO> adminDivDTOs = 
                procedureHelper.GetData<AdminDivSearchDTO>(
                    "administrative_division_search", filter);
            if (0 != adminDivDTOs.Count)
                queryResult.TotalRows = adminDivDTOs[0].TotalRows;
            List<AdminDivModel> adminDivs = new List<AdminDivModel>();
            foreach (var adminDivDTO in adminDivDTOs)
            {
                AdminDivModel adminDiv = new AdminDivModel();
                adminDiv.TotalRows = adminDivDTO.TotalRows;
                adminDiv.ID = adminDivDTO.ID;
                adminDiv.FatherID = adminDivDTO.FatherID;
                adminDiv.Name = adminDivDTO.Name;
                adminDiv.Type = adminDivDTO.Type;
                adminDiv.Level = adminDivDTO.Level;
                adminDivs.Add(adminDiv);
            }
            queryResult.Items = adminDivs;
            return (ResultCode.SUCCESS, queryResult);
        }
    }
}