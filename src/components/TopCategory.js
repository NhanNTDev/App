const TopCategory = () => {
  let categories = [
    {
      id: "1",
      title: "Rau Ăn Lá",
      totalItem: "100",
      image: "img/categories/rau_an_la.PNG",
    },
    {
      id: "2",
      title: "Rau Hoa Qủa",
      totalItem: "100",
      image: "img/categories/rau_hoa_qua.PNG",
    },
    {
      id: "3",
      title: "Rau Củ Gia Vị",
      totalItem: "100",
      image: "img/categories/rau_gia_vi.PNG",
    },
    {
      id: "4",
      title: "Củ",
      totalItem: "100",
      image: "img/categories/cu.PNG",
    },
    {
      id: "5",
      title: "Trái Cây",
      totalItem: "100",
      image: "img/categories/trai_cay.PNG",
    },
    {
      id: "6",
      title: "Hạt",
      totalItem: "100",
      image: "img/categories/hat.PNG",
    },
    {
      id: "7",
      title: "Nấm",
      totalItem: "100",
      image: "img/categories/nam.PNG",
    },
    {
      id: "8",
      title: "Hoa Tươi",
      totalItem: "100",
      image: "img/categories/hoa_tuoi.PNG",
    },
    {
      id: "9",
      title: "Khác",
      totalItem: "100",
      image: "img/categories/khac.PNG",
    },
  ];

  function renderItem (props) {
    return (
      <div className="item" key={props.id}>
        <div className="category-item">
          <a href="shop.html">
            <img className="img-fluid" src={props.image} alt="" />
            <h6>{props.title}</h6>
            <p>{props.totalItem} Sản Phẩm</p>
          </a>
        </div>
      </div>
    );
  };
  return (
    <>
      <section className="top-category section-padding">
        <div className="container">
          <div className="owl-carousel owl-carousel-category">
            {categories.map((category) => renderItem({ ...category }))}
          </div>
        </div>
      </section>
    </>
  );
};

export default TopCategory;
