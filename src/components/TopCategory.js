import React, { useEffect, useState } from "react";
import * as categoryService from "../services/category-service";
import { runScript } from "../utils/Common";

const TopCategory = () => {
  
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetChCategories = async () => {
      const categoryResponse = await categoryService.getAllCategoriesAPI();
      setCategories(categoryResponse);
    };
    fetChCategories();
  }, [])

  function renderItem(props) {
    console.log('category');
    console.log(props);
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
            {categories.map((category) => renderItem({ ...category }))}
          </div>
        </div>
      </section>
    </>
  );
};

export default TopCategory;
