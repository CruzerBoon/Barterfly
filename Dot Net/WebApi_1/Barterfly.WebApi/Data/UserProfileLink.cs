//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Barterfly.WebApi.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class UserProfileLink
    {
        public long Id { get; set; }
        public string NId { get; set; }
        public short Provider { get; set; }
        public short App { get; set; }
        public long UserProfile { get; set; }
        public System.DateTime CreatedDate { get; set; }
    
        public virtual UserProfile UserProfile1 { get; set; }
    }
}