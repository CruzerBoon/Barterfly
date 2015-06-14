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
    public class RequestItemCommentController : TableController<RequestItemComment>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<RequestItemComment>(context, Request, Services);
        }

        // GET tables/RequestItemComment
        public IQueryable<RequestItemComment> GetAllRequestItemComment(string requestItemId)
        {
            return Query().Where(i => i.RequestItem == requestItemId); 
        }

        // GET tables/RequestItemComment/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<RequestItemComment> GetRequestItemComment(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/RequestItemComment/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<RequestItemComment> PatchRequestItemComment(string id, Delta<RequestItemComment> patch)
        {
             return UpdateAsync(id, patch);
        }

        // POST tables/RequestItemComment
        public async Task<IHttpActionResult> PostRequestItemComment(RequestItemComment item)
        {
            RequestItemComment current = await InsertAsync(item);
            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/RequestItemComment/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteRequestItemComment(string id)
        {
             return DeleteAsync(id);
        }

    }
}