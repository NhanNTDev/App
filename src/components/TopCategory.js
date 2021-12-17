const TopCategory = (props) => {
  function renderItem(props) {
    return (
      <div className="item" key={props.id}>
        <div className="category-item">
          <a href="shop.html">
            <img className="img-fluid" src={props.image} alt="" />
            <h6>{props.name}</h6>
            <p>{props.totalItem} Sản Phẩm</p>
          </a>
        </div>
      </div>
    );
  }

  return (
    <>
      <section className="top-category section-padding">
        <div className="container">
          <div className="owl-carousel owl-carousel-category">
            
                  {props.listCategories.map((category) =>
                    renderItem({ ...category })
                  )}
               
          </div>
        </div>
      </section>
    </>
  );
};

export default TopCategory;
