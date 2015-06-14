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
    public class TradeItemRequestController : TableController<TradeItemRequest>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TradeItemRequest>(context, Request, Services);
        }

        // GET tables/TradeItemRequest
        public IQueryable<TradeItemRequest> GetAllTradeItemRequest(string tradeItemId)
        {
            return Query().Where(i => i.TradeItem == tradeItemId); 
        }

        // GET tables/TradeItemRequest/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TradeItemRequest> GetTradeItemRequest(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TradeItemRequest/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TradeItemRequest> PatchTradeItemRequest(string id, Delta<TradeItemRequest> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/TradeItemRequest
        public async Task<IHttpActionResult> PostTradeItemRequest(TradeItemRequest item)
        {
            TradeItemRequest current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TradeItemRequest/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTradeItemRequest(string id)
        {
             return DeleteAsync(id);
        }

    }
}