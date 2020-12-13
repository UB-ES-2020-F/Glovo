using System.Collections.Generic;

namespace glovo_webapi.Entities
{
    public class ProductGroup
    {
        public string Category { get; set; }
        public List<Product> Products { get; set; }
    }
}