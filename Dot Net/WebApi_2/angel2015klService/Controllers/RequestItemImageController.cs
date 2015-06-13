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
    public class RequestItemImageController : TableController<RequestItemImage>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<RequestItemImage>(context, Request, Services);
        }

        // GET tables/RequestItemImage?requestItemId=8
        public IQueryable<RequestItemImage> GetAllRequestItemImage(string requestItemId)
        {
            return Query().Where(i => i.RequestItem.Equals(requestItemId)); 
        }

        // GET tables/RequestItemImage/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<RequestItemImage> GetRequestItemImage(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/RequestItemImage/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<RequestItemImage> PatchRequestItemImage(string id, Delta<RequestItemImage> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/RequestItemImage
        public async Task<IHttpActionResult> PostRequestItemImage(RequestItemImage item)
        {
            RequestItemImage current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/RequestItemImage/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteRequestItemImage(string id)
        {
             return DeleteAsync(id);
        }

    }
}