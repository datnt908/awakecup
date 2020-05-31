using System.Collections.Generic;

namespace aspnetcore.Helpers
{
    public enum ResultCode
    {
        SUCCESS = 0x0000,
        SERVER_ERR = 0x0010,
        CLIENT_ERR = 0x0020,
        UN_AUTH = 0x0021,
        NOT_FOUND = 0x0022,
    }
    public class Result
    {
        public int Code { get; set; }
        public string Message { get; set; }
        public string Detail { get; set; }
    }
    public static class ResultHandler
    {
        private static Dictionary<int, KeyValuePair<int, Result>> _dictionary = null;

        public static void Initialize()
        {
            _dictionary = new Dictionary<int, KeyValuePair<int, Result>>();
            _dictionary.Add(0x0000, new KeyValuePair<int, Result>(
                200, new Result { Code = 200, Message = "Success", Detail = "" }));
            _dictionary.Add(0x0010, new KeyValuePair<int, Result>(
                500, new Result { Code = 500, Message = "Internal Server Error", Detail = "" }));
            _dictionary.Add(0x0020, new KeyValuePair<int, Result>(
                400, new Result { Code = 400, Message = "Bad Request", Detail = "" }));
            _dictionary.Add(0x0021, new KeyValuePair<int, Result>(
                401, new Result { Code = 401, Message = "Unauthorized", Detail = "" }));
            _dictionary.Add(0x0022, new KeyValuePair<int, Result>(
                404, new Result { Code = 404, Message = "Not found", Detail = "" }));
        }
        public static (int, Result) GetStatusCodeAndResult(ResultCode resultCode)
        {
            return (
                _dictionary[(int)resultCode].Key,
                _dictionary[(int)resultCode].Value
            );
        }
    }
}