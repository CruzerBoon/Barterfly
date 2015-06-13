using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.OData;
using Microsoft.WindowsAzure.Mobile.Service;
using angel2015klService.DataObjects;
using angel2015klService.Models;

namespace angel2015klService.Controllers
{
    public class TradeItemLikeController : TableController<TradeItemLike>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TradeItemLike>(context, Request, Services);
        }

        // GET tables/TradeItemLike
        public IQueryable<TradeItemLike> GetAllTradeItemLike(string tradeItemId)
        {
            return Query().Where(i => i.TradeItem.Equals(tradeItemId)); 
        }

        // GET tables/TradeItemLike/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TradeItemLike> GetTradeItemLike(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TradeItemLike/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TradeItemLike> PatchTradeItemLike(string id, Delta<TradeItemLike> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/TradeItemLike
        public async Task<IHttpActionResult> PostTradeItemLike(TradeItemLike item)
        {
            TradeItemLike current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TradeItemLike/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTradeItemLike(string id)
        {
             return DeleteAsync(id);
        }

    }
}