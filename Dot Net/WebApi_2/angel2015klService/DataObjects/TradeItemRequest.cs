using Microsoft.WindowsAzure.Mobile.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace angel2015klService.DataObjects
{
    public class TradeItemRequest : EntityData
    {
        public string TradeItem { get; set; }

        public string Name { get; set; }

        public string Tag { get; set; }

        public string RequestItemImg { get; set; }

        public string Remark { get; set; }
    }
}