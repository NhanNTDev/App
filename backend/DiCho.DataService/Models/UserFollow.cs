using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class UserFollow
    {
        public int Id { get; set; }
        public string FollowingId { get; set; }
        public string FollowingName { get; set; }
        public string FollowingImage { get; set; }
        public string FollowerId { get; set; }
        public string FollowerName { get; set; }
        public string FollowerImage { get; set; }

        public virtual AspNetUsers Follower { get; set; }
    }
}
