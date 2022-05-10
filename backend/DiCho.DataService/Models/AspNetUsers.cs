using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class AspNetUsers : IdentityUser<string>
    {
        public AspNetUsers()
        {
            Addresses = new HashSet<Address>();
            AspNetUserClaims = new HashSet<AspNetUserClaims>();
            AspNetUserLogins = new HashSet<AspNetUserLogins>();
            AspNetUserRoles = new HashSet<AspNetUserRoles>();
            AspNetUserTokens = new HashSet<AspNetUserTokens>();
            Farms = new HashSet<Farm>();
            Orders = new HashSet<Order>();
            Posts = new HashSet<Post>();
            Shipments = new HashSet<Shipment>();
            UserFollows = new HashSet<UserFollow>();
            WareHouses = new HashSet<WareHouse>();
        }
        public string Name { get; set; }
        public string Image { get; set; }
        public string Gender { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string Address { get; set; }
        public DateTime? CreateAt { get; set; }
        public int? WareHouseId { get; set; }
        public int? Type { get; set; }
        public bool Active { get; set; }
        public bool Published { get; set; }
        public int? ZoneId { get; set; }

        public virtual ICollection<Address> Addresses { get; set; }
        public virtual ICollection<AspNetUserClaims> AspNetUserClaims { get; set; }
        public virtual ICollection<AspNetUserLogins> AspNetUserLogins { get; set; }
        public virtual ICollection<AspNetUserRoles> AspNetUserRoles { get; set; }
        public virtual ICollection<AspNetUserTokens> AspNetUserTokens { get; set; }
        public virtual ICollection<Farm> Farms { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Post> Posts { get; set; }
        public virtual ICollection<Shipment> Shipments { get; set; }
        public virtual ICollection<UserFollow> UserFollows { get; set; }
        public virtual ICollection<WareHouse> WareHouses { get; set; }
    }
}
