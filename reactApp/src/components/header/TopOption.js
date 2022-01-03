import { Link } from "react-router-dom";

const TopOption = () => {
  const topRefs = [
    {
      id: "1",
      title: "Đăng ký người bán",
      link: "",
    },
    {
      id: "2",
      title: "Kết nối",
      link: "",
    },
    {
      id: "3",
      title: "Tải ứng dụng",
      link: "",
    },
  ];
  return (
    <div className="navbar-top bg-success pt-2 pb-2">
      <div className="container-fluid">
        <div className="row">
          <div className="col-lg-12 text-center">
            {topRefs.map((topRef, index) => (
              <Link
                key={topRef.id}
                to={topRef.link}
                className="mb-0 mr-2 text-white"
              >
                {topRef.title}{" "}
                {index === topRefs.length - 1 ? null : (
                  <span className="mb-0 ml-2 text-white">{"|"}</span>
                )}
              </Link>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default TopOption;
