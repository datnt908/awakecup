using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using Microsoft.AspNetCore.StaticFiles;

namespace aspnetcore.Helpers
{
    public class MyFileStream
    {
        private static readonly Dictionary<string, string> prefixPaths = new Dictionary<string, string>
        {
            {"ProductImages", "wwwroot/appdata/products"},
        };

        public string FileName { get; set; }
        public byte[] FileContent { get; set; }

        public MyFileStream()
        {
            FileName = string.Empty;
            FileContent = null;
        }

        public void ConvertFromIFormFile(IFormFile formFile)
        {
            using (MemoryStream memoryStream = new MemoryStream())
            {
                formFile.CopyTo(memoryStream);
                FileName = formFile.FileName;
                FileContent = memoryStream.ToArray();
            }
        }

        public void CreateProductImage()
        {
            string prefixPath = prefixPaths["ProductImages"];
            string filePath = Path.Combine(
                Directory.GetCurrentDirectory(), prefixPath, FileName);
            if (!Directory.Exists(Path.GetDirectoryName(filePath)))
                Directory.CreateDirectory(Path.GetDirectoryName(filePath));
            if (null != FileContent && 0 != FileContent.Length)
                File.WriteAllBytes(filePath, FileContent);
        }

        public void DeleteProductImage()
        {
            string prefixPath = prefixPaths["ProductImages"];
            string filePath = Path.Combine(
                Directory.GetCurrentDirectory(), prefixPath, FileName);
            string newFilePath = Path.Combine(
                Directory.GetCurrentDirectory(), prefixPath, FileName.Replace("_1.", "_0."));
            if (File.Exists(newFilePath))
                File.Delete(newFilePath);
            if (File.Exists(filePath))
                File.Move(filePath, newFilePath);
        }
    }
}