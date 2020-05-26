using System.Collections.Generic;
using System.IO;

namespace aspnetcore.Helpers
{
    public enum PrefixPaths
    {
        PRODUCTS = 1,
    }
    public class FileHandler
    {
        private static Dictionary<int, KeyValuePair<string, string>> dictionary = null;

        public static void Initialize()
        {
            dictionary = new Dictionary<int, KeyValuePair<string, string>>();
            dictionary.Add(1, new KeyValuePair<string, string>(
                "appdata/products/", "default.png"));
        }
        public static string GetFileUrl(PrefixPaths prefixEnum, string fileName)
        {
            string prefixPath = dictionary[(int)prefixEnum].Key;
            string filePath = Path.Combine(
                Directory.GetCurrentDirectory(), "wwwroot", prefixPath, fileName);
            if (File.Exists(filePath))
                return prefixPath + fileName;
            else
                return prefixPath + dictionary[(int)prefixEnum].Value;
        }
    }
}