using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class UserFollowModel
    {
        public int? Id { get; set; }
        public string FollowingId { get; set; }
        public string FollowingName { get; set; }
        public string FollowingImage { get; set; }
        public string FollowerId { get; set; }
        public string FollowerName { get; set; }
        public string FollowerImage { get; set; }
    }

    public class UserFollowCreateModel
    {
        public string FollowingId { get; set; }
        public string FollowingName { get; set; }
        public string FollowingImage { get; set; }
        public string FollowerId { get; set; }
        public string FollowerName { get; set; }
        public string FollowerImage { get; set; }
    }
}
