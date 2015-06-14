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
    //[AuthorizeLevel(AuthorizationLevel.Anonymous)]
    [AuthorizeLevel(AuthorizationLevel.User)]
    public class TradeItemController : TableController<TradeItem>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TradeItem>(context, Request, Services);
        }

        // GET tables/TradeItem
        public IQueryable<TradeItem> GetAllTradeItem()
        {
            var currentUser = User as Microsoft.WindowsAzure.Mobile.Service.Security.ServiceUser;

            return Query().Where(i => i.UserId == currentUser.Id);
        }

        // GET tables/TradeItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TradeItem> GetTradeItem(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TradeItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TradeItem> PatchTradeItem(string id, Delta<TradeItem> patch)
        {
            return UpdateAsync(id, patch);
        }

        // POST tables/TradeItem
        public async Task<IHttpActionResult> PostTradeItem(TradeItem item)
        {
            TradeItem current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TradeItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTradeItem(string id)
        {
            return DeleteAsync(id);
        }

    }
}