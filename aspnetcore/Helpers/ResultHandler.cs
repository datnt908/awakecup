using System.Collections.Generic;

namespace aspnetcore.Helpers
{
    public enum ResultCode
    {
        SUCCESS = 0x0000,
        ORDER_STT_NOT_FOUND = 0x0001,
        ORDER_INFO_INVALID = 0x0002,
        PROVINCE_NOT_FOUND = 0x0003,
        DISTRICT_NOT_FOUND = 0x0004,
        COMMUNE_NOT_FOUND = 0x0005,
        ORDER_NOT_FOUND = 0x0006,
        PRODUCT_NOT_FOUND = 0x0007,
        PRODUCT_DUPLICATED = 0x0008,
        EMPTY_ORDER_CART = 0x0009,
        EMPTY_ORDER_NAME = 0x000A,
        EMPTY_ORDER_PHONE = 0x000B,
        EMPTY_ORDER_ADDR = 0x000C,
        ACCOUNT_NOT_FOUND = 0x000D,
        ACCOUNT_PASS_INVALID = 0x000E,
        PRODUCT_INFO_INVALID = 0x000F,
        CATEGORY_NOT_FOUND = 0x0010,
        EMPTY_PRODUCT_CODE = 0x0011,
        EMPTY_PRODUCT_TITLE = 0x0012,
        EMPTY_PRODUCT_IMAGE = 0x0013,
    }
    public class Result
    {
        public ResultCode Code { get; set; }
        public string Message { get; set; }
        public string Detail { get; set; }
    }
    public static class ResultHandler
    {
        private static Dictionary<ResultCode, KeyValuePair<int, Result>> _dictionary = null;

        public static void Initialize()
        {
            _dictionary = new Dictionary<ResultCode, KeyValuePair<int, Result>>();
            _dictionary.Add(ResultCode.SUCCESS, new KeyValuePair<int, Result>(
                200, new Result { Code = ResultCode.SUCCESS, Message = "Success", Detail = "" }));
            _dictionary.Add(ResultCode.ORDER_STT_NOT_FOUND, new KeyValuePair<int, Result>(
                500, new Result { Code = ResultCode.ORDER_STT_NOT_FOUND, Message = "Bad Request", Detail = "Not found order status" }));
            _dictionary.Add(ResultCode.ORDER_INFO_INVALID, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.ORDER_INFO_INVALID, Message = "Bad Request", Detail = "Invalid Order information" }));
            _dictionary.Add(ResultCode.PROVINCE_NOT_FOUND, new KeyValuePair<int, Result>(
                404, new Result { Code = ResultCode.PROVINCE_NOT_FOUND, Message = "Not Found", Detail = "Not found province for insert order" }));
            _dictionary.Add(ResultCode.DISTRICT_NOT_FOUND, new KeyValuePair<int, Result>(
                404, new Result { Code = ResultCode.DISTRICT_NOT_FOUND, Message = "Not Found", Detail = "Not found district for insert order" }));
            _dictionary.Add(ResultCode.COMMUNE_NOT_FOUND, new KeyValuePair<int, Result>(
                404, new Result { Code = ResultCode.COMMUNE_NOT_FOUND, Message = "Not Found", Detail = "Not found commune for insert order" }));
            _dictionary.Add(ResultCode.ORDER_NOT_FOUND, new KeyValuePair<int, Result>(
                500, new Result { Code = ResultCode.ORDER_NOT_FOUND, Message = "Bad Request", Detail = "Not found order" }));
            _dictionary.Add(ResultCode.PRODUCT_NOT_FOUND, new KeyValuePair<int, Result>(
                404, new Result { Code = ResultCode.PRODUCT_NOT_FOUND, Message = "Not Found", Detail = "Not found product" }));
            _dictionary.Add(ResultCode.PRODUCT_DUPLICATED, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.PRODUCT_DUPLICATED, Message = "Bad Request", Detail = "Duplicated product for insert" }));
            _dictionary.Add(ResultCode.EMPTY_ORDER_CART, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_ORDER_CART, Message = "Bad Request", Detail = "Cart and Cart detail is empty" }));
            _dictionary.Add(ResultCode.EMPTY_ORDER_NAME, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_ORDER_NAME, Message = "Bad Request", Detail = "Firstname or Lastname is empty" }));
            _dictionary.Add(ResultCode.EMPTY_ORDER_PHONE, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_ORDER_PHONE, Message = "Bad Request", Detail = "Order's phone number is empty" }));
            _dictionary.Add(ResultCode.EMPTY_ORDER_ADDR, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_ORDER_ADDR, Message = "Bad Request", Detail = "Order's address number is empty" }));
            _dictionary.Add(ResultCode.ACCOUNT_NOT_FOUND, new KeyValuePair<int, Result>(
                404, new Result { Code = ResultCode.ACCOUNT_NOT_FOUND, Message = "Not Found", Detail = "Account is not existed" }));
            _dictionary.Add(ResultCode.ACCOUNT_PASS_INVALID, new KeyValuePair<int, Result>(
                401, new Result { Code = ResultCode.ACCOUNT_PASS_INVALID, Message = "Unauthorized", Detail = "Account's password is invalid" }));
            _dictionary.Add(ResultCode.PRODUCT_INFO_INVALID, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.PRODUCT_INFO_INVALID, Message = "Bad Request", Detail = "Invalid Product information" }));
            _dictionary.Add(ResultCode.CATEGORY_NOT_FOUND, new KeyValuePair<int, Result>(
                404, new Result { Code = ResultCode.CATEGORY_NOT_FOUND, Message = "Not Found", Detail = "Not found category" }));
            _dictionary.Add(ResultCode.EMPTY_PRODUCT_CODE, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_PRODUCT_CODE, Message = "Bad Request", Detail = "Product code is empty" }));
            _dictionary.Add(ResultCode.EMPTY_PRODUCT_TITLE, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_PRODUCT_TITLE, Message = "Bad Request", Detail = "Product title is empty" }));
            _dictionary.Add(ResultCode.EMPTY_PRODUCT_IMAGE, new KeyValuePair<int, Result>(
                400, new Result { Code = ResultCode.EMPTY_PRODUCT_IMAGE, Message = "Bad Request", Detail = "Product image is empty" }));

        }
        public static (int, Result) GetStatusCodeAndResult(ResultCode resultCode)
        {
            return (
                _dictionary[resultCode].Key,
                _dictionary[resultCode].Value
            );
        }
    }
}