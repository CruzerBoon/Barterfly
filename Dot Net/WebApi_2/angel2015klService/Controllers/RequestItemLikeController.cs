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
    public class RequestItemLikeController : TableController<RequestItemLike>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<RequestItemLike>(context, Request, Services);
        }

        // GET tables/RequestItemLike
        public IQueryable<RequestItemLike> GetAllRequestItemLike(string requestItemId)
        {
            return Query().Where(i => i.RequestItem.Equals(requestItemId)); 
        }

        // GET tables/RequestItemLike/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<RequestItemLike> GetRequestItemLike(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/RequestItemLike/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<RequestItemLike> PatchRequestItemLike(string id, Delta<RequestItemLike> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/RequestItemLike
        public async Task<IHttpActionResult> PostRequestItemLike(RequestItemLike item)
        {
            RequestItemLike current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/RequestItemLike/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteRequestItemLike(string id)
        {
             return DeleteAsync(id);
        }

    }
}