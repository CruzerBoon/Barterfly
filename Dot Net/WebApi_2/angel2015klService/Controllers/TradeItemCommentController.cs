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
    public class TradeItemCommentController : TableController<TradeItemComment>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TradeItemComment>(context, Request, Services);
        }

        // GET tables/TradeItemComment
        public IQueryable<TradeItemComment> GetAllTradeItemComment(string tradeItemId)
        {
            return Query().Where(i => i.TradeItem.Equals(tradeItemId)); 
        }

        // GET tables/TradeItemComment/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TradeItemComment> GetTradeItemComment(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TradeItemComment/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TradeItemComment> PatchTradeItemComment(string id, Delta<TradeItemComment> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/TradeItemComment
        public async Task<IHttpActionResult> PostTradeItemComment(TradeItemComment item)
        {
            TradeItemComment current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TradeItemComment/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTradeItemComment(string id)
        {
             return DeleteAsync(id);
        }

    }
}