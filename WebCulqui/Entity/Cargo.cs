using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebCulqui.Entity
{
    public class Cargo
    {
            public string amount { get; set; }
            public string currency_code { get; set; }
            public string email { get; set; }
            public AntifraudDetails antifraud_details { get; set; }
            public string source_id { get; set; }
     }
}