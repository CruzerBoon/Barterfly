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
    public class TradeItemWishListController : TableController<TradeItemWishList>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TradeItemWishList>(context, Request, Services);
        }

        // GET tables/TradeItemWishList
        public IQueryable<TradeItemWishList> GetAllTradeItemWishList(string tradeItemId)
        {
            return Query().Where(i => i.TradeItem == tradeItemId); 
        }

        // GET tables/TradeItemWishList/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TradeItemWishList> GetTradeItemWishList(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TradeItemWishList/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TradeItemWishList> PatchTradeItemWishList(string id, Delta<TradeItemWishList> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/TradeItemWishList
        public async Task<IHttpActionResult> PostTradeItemWishList(TradeItemWishList item)
        {
            TradeItemWishList current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TradeItemWishList/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTradeItemWishList(string id)
        {
             return DeleteAsync(id);
        }

    }
}