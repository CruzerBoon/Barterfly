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
    public class RequestItemController : TableController<RequestItem>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<RequestItem>(context, Request, Services);
        }

        // GET tables/RequestItem
        public IQueryable<RequestItem> GetAllRequestItem()
        {
            var currentUser = User as Microsoft.WindowsAzure.Mobile.Service.Security.ServiceUser;

            return Query().Where(i => i.UserId.Equals(currentUser.Id));
        }

        // GET tables/RequestItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<RequestItem> GetRequestItem(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/RequestItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<RequestItem> PatchRequestItem(string id, Delta<RequestItem> patch)
        {
            return UpdateAsync(id, patch);
        }

        // POST tables/RequestItem
        public async Task<IHttpActionResult> PostRequestItem(RequestItem item)
        {
            RequestItem current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/RequestItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteRequestItem(string id)
        {
            return DeleteAsync(id);
        }

    }
}