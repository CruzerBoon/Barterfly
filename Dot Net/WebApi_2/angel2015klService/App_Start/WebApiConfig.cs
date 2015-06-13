using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Web.Http;
using Microsoft.WindowsAzure.Mobile.Service;
using angel2015klService.DataObjects;
using angel2015klService.Models;
using System.Web.Http.Cors;

namespace angel2015klService
{
    public static class WebApiConfig
    {
        public static void Register()
        {
            // Use this class to set configuration options for your mobile service
            ConfigOptions options = new ConfigOptions();
            options.CorsPolicy = new EnableCorsAttribute("*", "*", "*", "*");

            // Use this class to set WebAPI configuration options
            HttpConfiguration config = ServiceConfig.Initialize(new ConfigBuilder(options));

            //var cors = new EnableCorsAttribute("http://localhost:50015", "*", "*");
            //var cors = new EnableCorsAttribute("*", "*", "*", "*");
            //config.EnableCors(cors);

            // To display errors in the browser during development, uncomment the following
            // line. Comment it out again when you deploy your service for production use.
            config.IncludeErrorDetailPolicy = IncludeErrorDetailPolicy.Always;

            //config.EnableQuerySupport();

#if(DEBUG)
            config.SetIsHosted(true);
#endif

            Database.SetInitializer(new angel2015klInitializer());
        }
    }

    public class angel2015klInitializer : ClearDatabaseSchemaIfModelChanges<angel2015klContext>
    {
        protected override void Seed(angel2015klContext context)
        {
            List<TodoItem> todoItems = new List<TodoItem>
            {
                new TodoItem { Id = Guid.NewGuid().ToString(), Text = "First item", Complete = false },
                new TodoItem { Id = Guid.NewGuid().ToString(), Text = "Second item", Complete = false },
            };

            foreach (TodoItem todoItem in todoItems)
            {
                context.Set<TodoItem>().Add(todoItem);
            }

            base.Seed(context);
        }
    }
}

