using System.Collections.Generic;

namespace glovo_webapi.Models.Product
{
    public class ProductGroupModel
    {
        public string Category { get; set; }
        public IEnumerable<ProductModel> Products { get; set; }
    }
}