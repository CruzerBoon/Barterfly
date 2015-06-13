using Microsoft.WindowsAzure.Mobile.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace angel2015klService.DataObjects
{
    public class TradeItemWishList : EntityData
    {
        public string TradeItem { get; set; }

        public string UserId { get; set; }
    }
}