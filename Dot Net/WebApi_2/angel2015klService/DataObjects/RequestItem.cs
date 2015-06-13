using Microsoft.WindowsAzure.Mobile.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace angel2015klService.DataObjects
{
    public class RequestItem : EntityData
    {
        public string Name { get; set; }

        public string Remark { get; set; }

        public string Tag { get; set; }

        public short ExchangeMethod { get; set; }

        public DateTime? PostExpireDate { get; set; }

        public short Category { get; set; }

        public bool IsActive { get; set; }

        public string UserId { get; set; }

        public string UserName { get; set; }

        public string UserProfileImg { get; set; }

        //public string Condition { get; set; }

        //public string Reason { get; set; }

        //public DateTime? ManufacturedDate { get; set; }

        //public DateTime? ExpireDate { get; set; }

        //public double Latitude { get; set; }

        //public double Longitude { get; set; }
    }
}