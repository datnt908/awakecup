using System.Collections.Generic;
using System.Data;
using Dapper;
using MySql.Data.MySqlClient;
using System.Linq;

namespace aspnetcore.Repositories
{
    public interface IProcedureHelper
    {
        List<T> GetData<T>(string procedureName, object paramsObj);
    }

    public class ProcedureParamInfo
    {
        public string PARAMETER_NAME { get; set; }
        public string PARAMETER_MODE { get; set; }
        public string DATA_TYPE { get; set; }
        public int CHARACTER_MAXIMUM_LENGTH { get; set; }
    }

    public class ProcedureHelper : IProcedureHelper
    {
        public static string ConnectionString;

        private List<ProcedureParamInfo> GetParamInfos(IDbConnection conn, string procedureName)
        {
            var result = conn.Query<ProcedureParamInfo>(
                "SELECT PARAMETER_NAME, PARAMETER_MODE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH "
                + $"FROM information_schema.parameters where specific_name = '{procedureName}'");
            return result.ToList();
        }

        public List<T> GetData<T>(string procedureName, object paramsObj)
        {
            List<T> result;
            using (IDbConnection conn = new MySqlConnection(ConnectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var paramInfos = GetParamInfos(conn, procedureName);
                DynamicParameters parameters = new DynamicParameters();
                var properties = paramsObj.GetType().GetProperties();

                foreach (var param in paramInfos)
                {
                    var property = properties
                        .Where(x => x.Name.ToLower() == param.PARAMETER_NAME.Replace("_", "").ToLower())
                        .FirstOrDefault();
                    if (property == null)
                        continue;
                    parameters.Add(param.PARAMETER_NAME, property.GetValue(paramsObj));
                }

                result = conn.Query<T>(
                    procedureName, parameters, null, true, null, CommandType.StoredProcedure).ToList();
            }
            return result;
        }
    }
}