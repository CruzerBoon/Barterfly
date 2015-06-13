//using Microsoft.WindowsAzure.Mobile.Service.Security;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Net;
//using System.Net.Http;
//using System.Web.Http;
//using System.Web.Http.Description;

//namespace angel2015klService.Controllers
//{
//    [AuthorizeLevel(Microsoft.WindowsAzure.Mobile.Service.Security.AuthorizationLevel.User)]
//    public class SecController : ApiControllerBase
//    {
//        [ResponseType(typeof(Models.UserProfile))]
//        [ActionName("profile")]
//        [HttpPost]
//        public IHttpActionResult Profile()
//        {
//            // Get the logged in user
//            var currentUser = User as ServiceUser;


//            Models.UserProfile result;

//            string nid = "";

//            try
//            {
//                var query = (from a in base.MyEntities.UserProfiles where a.UserProfileLinks.Any(b => b.NId == nid) select a);
//                result = query.FirstOrDefault();

//                if(result == null)
//                {
//                    result = AddProfile(nid);

//                    if (!string.IsNullOrEmpty(base.LastFriendlyErrorMessage))
//                        result = null;
//                }
//            }
//            catch (Exception ex)
//            {
//                base.CreateLog(this, ex);
//                return InternalServerError();
//            }

//            if (result != null)
//            {
//                result.CreatedDate = DateTime.SpecifyKind(result.CreatedDate, DateTimeKind.Utc);
//                result.LastUpdateDate = DateTime.SpecifyKind(result.LastUpdateDate, DateTimeKind.Utc);
//            }

//            return Ok(result);
//        }

//        private Models.UserProfile AddProfile(string nid)
//        {
//            Models.UserProfile result = null;

//            try
//            {
//                result = new Models.UserProfile();
//                result.Avatar = "";
//                result.Email = "";
//                result.LastUpdateDate = DateTime.UtcNow;
//                result.Name = "";
//                result.Status = Helper.Constant.ProfileStatus.Active;

//                result = base.MyEntities.UserProfiles.Add(result);

//                Models.UserProfileLink userProfileLink = new Models.UserProfileLink();
//                userProfileLink.NId = nid;
//                userProfileLink.App = Helper.Constant.App.Barterfly;
//                userProfileLink.Provider = Helper.Constant.LoginProvider.Facebook;
//                userProfileLink.UserProfile = result.Id;

//                userProfileLink = base.MyEntities.UserProfileLinks.Add(userProfileLink);

//                base.MyEntities.SaveChanges();
//            }
//            catch (Exception ex)
//            {
//                base.CreateLog(this, ex);
//                base.LastFriendlyErrorMessage = "Fails to create profile record.";
//            }

//            if (result != null)
//            {
//                result.CreatedDate = DateTime.SpecifyKind(result.CreatedDate, DateTimeKind.Utc);
//                result.LastUpdateDate = DateTime.SpecifyKind(result.LastUpdateDate, DateTimeKind.Utc);
//            }

//            return result;
//        }
//    }
//}
