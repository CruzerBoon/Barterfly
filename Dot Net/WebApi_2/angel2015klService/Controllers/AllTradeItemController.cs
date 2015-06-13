using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Microsoft.WindowsAzure.Mobile.Service;
using angel2015klService.DataObjects;

namespace angel2015klService.Controllers
{
    public class AllTradeItemController : ApiController
    {
        public ApiServices Services { get; set; }

        // GET api/AllTradeItem
        [HttpGet]
        public IQueryable<TradeItem> AllTradeItem()
        {
            angel2015klService.Models.angel2015klContext context = new Models.angel2015klContext();
            var queryResults = from item in context.TradeItems
                               select item;

            return queryResults;
        }
    }
}
