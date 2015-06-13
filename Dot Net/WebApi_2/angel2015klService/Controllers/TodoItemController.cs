using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.OData;
using Microsoft.WindowsAzure.Mobile.Service;
using angel2015klService.DataObjects;
using angel2015klService.Models;
using System.Web.Http.Cors;

namespace angel2015klService.Controllers
{
    public class TodoItemController : TableController<TodoItem>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<TodoItem>(context, Request, Services);
        }

        // GET tables/TodoItem
        public IQueryable<TodoItem> GetAllTodoItems()
        {
            return Query();
        }

        // GET tables/TodoItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public SingleResult<TodoItem> GetTodoItem(string id)
        {
            return Lookup(id);
        }

        // PATCH tables/TodoItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task<TodoItem> PatchTodoItem(string id, Delta<TodoItem> patch)
        {
            return UpdateAsync(id, patch);
        }

        // POST tables/TodoItem
        public async Task<IHttpActionResult> PostTodoItem(TodoItem item)
        {
            TodoItem current = await InsertAsync(item);

            //var re = Request;
            //var headers = re.Headers;
            //string token = "";

            //var currentUser = User as Microsoft.WindowsAzure.Mobile.Service.Security.ServiceUser;

            //if (headers.Contains("X-ZUMO-AUTH"))
            //{
            //    token = headers.GetValues("X-ZUMO-AUTH").First();
            //}

            //try
            //{
            //    Facebook.FacebookClient fbClient = new Facebook.FacebookClient(token);

            //    //fbClient.AppId = "1457909841175150";
            //    //fbClient.AppSecret = "551216f39249b8a219ce2b65f6da4f5e";

            //    var Id = currentUser.Identity.Name.Split(':').Last();

            //    var data = await fbClient.GetTaskAsync("/" + Id, new System.Collections.Generic.Dictionary<string, object> { { "access_token", token } });

            //    current.Text = data.GetType().ToString();
            //}
            //catch (System.Exception ex)
            //{
            //    throw;
            //}

            var currentUser = User as Microsoft.WindowsAzure.Mobile.Service.Security.ServiceUser;

            current.Text = currentUser.Id; //Facebook:948918238471759

            return CreatedAtRoute("Tables", new { id = current.Id }, current);
        }

        // DELETE tables/TodoItem/48D68C86-6EA6-4C25-AA33-223FC9A27959
        public Task DeleteTodoItem(string id)
        {
            return DeleteAsync(id);
        }
    }
}