import { Link } from "react-router-dom";

const NavBarItem = (props) => {
  return (
    <div key={props.id}>
      {props.id === "1" ? (
        <li className="nav-item">
          <Link className="nav-link shop" to={props.link}>
            <span className="mdi mdi-store"></span> {props.title}
          </Link>
        </li>
      ) : props.childrens.length > 0 ? (
        <li className="nav-item dropdown">
          <Link
            className="nav-link dropdown-toggle"
            to="#"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            {props.title}
          </Link>
          <div className="dropdown-menu">
            {props.childrens.map((child) => (
              <Link key={child.id} className="dropdown-item" to={child.link}>
                <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                {child.title}
              </Link>
            ))}
          </div>
        </li>
      ) : (
        <li className="nav-item">
          <Link className="nav-link" to={props.link}>
            {props.title}
          </Link>
        </li>
      )}
    </div>
  );
};

export default NavBarItem;
