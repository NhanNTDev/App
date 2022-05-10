
import { Link } from "react-router-dom";

const TopCategory = ({categories}) => {
  function renderItem(props) {
    return (
      <div className="item" key={props.id}>
        <div className="category-item">
          <Link to={`/search-result?category=${props.name}`}>
            <img className="img-fluid" src={props.image} alt="" />
            <h6>{props.name}</h6>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <>
      <section className="top-category section-padding">
        <div className="container">
          <div className="owl-carousel owl-carousel-category">
            {categories &&
              categories.map((category) =>
                renderItem({ ...category })
              )}
          </div>
        </div>
      </section>
    </>
  );
};

export default TopCategory;
