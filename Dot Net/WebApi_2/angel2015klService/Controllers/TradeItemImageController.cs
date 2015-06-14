using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.OData;
using Microsoft.WindowsAzure.Mobile.Service;
using angel2015klService.DataObjects;
using angel2015klService.Models;
using Microsoft.WindowsAzure.Mobile.Service.Security;

namespace angel2015klService.Controllers
{
    [AuthorizeLevel(AuthorizationLevel.User)]
    public class TradeItemImageController : TableController<TradeItemImage>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TradeItemImage>(context, Request, Services);
        }

        // GET tables/TradeItemImage?tradeItemId=12222
        public IQueryable<TradeItemImage> GetAllTradeItemImage(string tradeItemId)
        {
            return Query().Where(i => i.TradeItem == tradeItemId); 
        }

        // GET tables/TradeItemImage/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TradeItemImage> GetTradeItemImage(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TradeItemImage/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TradeItemImage> PatchTradeItemImage(string id, Delta<TradeItemImage> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/TradeItemImage
        public async Task<IHttpActionResult> PostTradeItemImage(TradeItemImage item)
        {
            TradeItemImage current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TradeItemImage/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTradeItemImage(string id)
        {
             return DeleteAsync(id);
        }

    }
}