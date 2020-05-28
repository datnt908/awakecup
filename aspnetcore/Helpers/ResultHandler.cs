using System.Collections.Generic;

namespace aspnetcore.Helpers
{
    public enum ResultCode
    {
        SUCCESS = 0x0000,
        SERVER_ERR = 0x0010,
        CLIENT_ERR = 0x0020,
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
                200, new Result { Code = 0x0000, Message = "Success", Detail = "" }));
            _dictionary.Add(0x0010, new KeyValuePair<int, Result>(
                500, new Result { Code = 0x0010, Message = "Internal Server Error", Detail = "" }));
            _dictionary.Add(0x0020, new KeyValuePair<int, Result>(
                400, new Result { Code = 0x0020, Message = "Bad Request", Detail = "" }));
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