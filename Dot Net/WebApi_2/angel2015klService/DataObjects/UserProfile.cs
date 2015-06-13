using Microsoft.WindowsAzure.Mobile.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace angel2015klService.DataObjects
{
    public class UserProfile : EntityData
    {
        public string ProfileImage { get; set; }
        public string Email { get; set; }

    }
}