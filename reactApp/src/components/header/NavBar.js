import NavBarItem from "./NavBarItem";

const NavBar = () => {
  const navbarItems = [
    {
      id: "1",
      title: "Trang Chủ",
      childrens: [],
      link: "/home",
    },
    {
      id: "2",
      title: "Chiến dịch trong tuần",
      childrens: [],
      link: "/all-campaigns?type=weekly",
    },
    {
      id: "3",
      title: "Chiến dịch khác",
      childrens: [],
      link: "/all-campaigns?type=other",
    },
    {
      id: "4",
      title: "Cộng đồng",
      childrens: [],
      link: "/social",
    },
    {
      id: "5",
      title: "Cá Nhân",
      childrens: [
        {
          id: "1",
          title: "Thông Tin Cá Nhân",
          link: "/account",
        },
        {
          id: "2",
          title: "Thông Tin Giao Hàng",
          link: "/address",
        },
        {
          id: "3",
          title: "Lịch Sử Đặt Hàng",
          link: "/orderlist",
        },
        {
          id: "4",
          title: "Đổi Mật Khẩu",
          link: "/changePassword",
        },
      ],
      link: "",
    },
    {
      id: "6",
      title: "Liên Hệ",
      childrens: [],
      link: "/home",
    },
    {
      id: "7",
      title: "Khác",
      childrens: [
        {
          id: "1",
          title: "Page Not Found",
          link: "/page-not-found",
        },
      ],
      link: "",
    },
  ];
  return (
    <>
      <nav className="navbar navbar-expand-lg navbar-light osahan-menu-2 pad-none-mobile">
        <div className="container-fluid">
          <div className="collapse navbar-collapse" id="navbarText">
            <ul className="navbar-nav mr-auto mt-2 mt-lg-0 margin-auto">
              {navbarItems.map((navbarItem) => (
                <NavBarItem key={navbarItem.id} {...navbarItem} />
              ))}
            </ul>
          </div>
        </div>
      </nav>
    </>
  );
};

export default NavBar;
