using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace angel2015klService.Controllers
{
    public abstract class ApiControllerBase : ApiController
    {
        private Models.angel2015kl_dbEntities _myEntities;

        protected Models.angel2015kl_dbEntities MyEntities
        {
            get
            {
                if (_myEntities == null)
                {
                    _myEntities = new Models.angel2015kl_dbEntities();
                    _myEntities.Configuration.LazyLoadingEnabled = false;
                    _myEntities.Configuration.ProxyCreationEnabled = false;
                }

                return _myEntities;
            }
        }

        protected string LastFriendlyErrorMessage { get; set; }

        protected string LastErrorMessage { get; set; }

        protected void CreateLog(Object sender, Exception ex)
        {
            //System.Diagnostics.EventLog appLog = new System.Diagnostics.EventLog();
            //appLog.Source = "MASTIS";

            if (string.IsNullOrEmpty(LastErrorMessage))
            {
                LastErrorMessage = "";
            }

            //appLog.WriteEntry(ex.Message);
            LastErrorMessage += ex.Message;

            Exception inner = ex.InnerException;

            while (inner != null)
            {
                LastErrorMessage += inner.Message;
                //appLog.WriteEntry(inner.Message);
                inner = inner.InnerException;
            }

            System.Diagnostics.Trace.TraceError("Sender: " + sender.ToString() + "\nMessage: " + LastErrorMessage);
        }

        [NonAction]
        public new void Dispose()
        {
            if (_myEntities != null)
            {
                _myEntities.Dispose();
                _myEntities = null;
            }

            base.Dispose();
        }
    }
}
