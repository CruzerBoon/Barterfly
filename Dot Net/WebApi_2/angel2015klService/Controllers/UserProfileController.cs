using angel2015klService.Models;
using Microsoft.WindowsAzure.Mobile.Service;
using Microsoft.WindowsAzure.Mobile.Service.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
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
        public DataObjects.UserProfile GetUserProfile()
        {
            DataObjects.UserProfile result = new DataObjects.UserProfile();

            // Get the logged in user
            var currentUser = User as ServiceUser;
            result.Id = currentUser.Id;
            result.ProfileImage = "abc";

            return result;
        }
    }
}
