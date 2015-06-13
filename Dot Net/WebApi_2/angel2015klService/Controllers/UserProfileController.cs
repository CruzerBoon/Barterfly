using angel2015klService.Models;
using Microsoft.WindowsAzure.Mobile.Service;
using Microsoft.WindowsAzure.Mobile.Service.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;

namespace angel2015klService.Controllers
{
    public class UserProfileController : TableController<DataObjects.UserProfile>
    {
        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            angel2015klContext context = new angel2015klContext();
            DomainManager = new EntityDomainManager<DataObjects.UserProfile>(context, Request, Services);
        }

        // GET tables/UserProfile
        public DataObjects.UserProfile GetUserProfile(string id)
        {
            //var re = Request;
            //var headers = re.Headers;
            //string token = "";

            var currentUser = User as ServiceUser;

            //if (headers.Contains("X-ZUMO-AUTH"))
            //{
            //    token = headers.GetValues("X-ZUMO-AUTH").First();
            //}

            //try
            //{
            //    Facebook.FacebookClient fbClient = new Facebook.FacebookClient(token);

            //    fbClient.AppId = "1457909841175150";
            //    fbClient.AppSecret = "551216f39249b8a219ce2b65f6da4f5e";


            //    var data = await fbClient.GetTaskAsync("/" + Id, new Dictionary<string, object> { { "access_token", token } });

            //    data.GetType().ToString();
            //}
            //catch (Exception ex)
            //{

            //    throw;
            //}

            DataObjects.UserProfile result = new DataObjects.UserProfile();

            result.ProfileImage = "abc";

            //var Id = currentUser.Identity.Name.Split(':').Last();
            //result.Id = currentUser.Id;
            //result.ProfileImage = string.Format(@"https://graph.facebook.com/{0}/picture?width=200&height=200", Id.ToString());

            return result;
        }
    }
}
