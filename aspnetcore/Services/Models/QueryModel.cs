using System.Collections;

namespace aspnetcore.Services.Models
{
    public class QueryModel
    {
        public int TotalRows { get; set; }
        public IEnumerable Items { get; set; }
        public QueryModel()
        {
            TotalRows = 0;
            Items = null;
        }
    }
}