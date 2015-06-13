using Microsoft.WindowsAzure.Mobile.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace angel2015klService.DataObjects
{
    public class RequestItemImage : EntityData
    {
        public string RequestItem { get; set; }

        public string ImgUrl { get; set; }

        public string Caption { get; set; }
    }
}