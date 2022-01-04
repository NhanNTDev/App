import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import FarmDetail from "../components/farm/FarmDetail";
import FarmPicture from "../components/farm/FarmPicture";
import ProductDetail from "../components/product/ProductDetail";
import {
  page1_farm,
  page1_product,
  page2_product,
  page3_product,
} from "../constants/Data";
import { deleteScript, runScript } from "../utils/Common";

const Farm = () => {
  const param = useParams();
  const [farm, setFarm] = useState({});
  const [farms, setFarms] = useState([]);

  useEffect(() => {
    deleteScript();
    setFarms(page1_farm);
    console.log(1);
  }, []);


  useEffect(() => {
    setFarm(farms.find((c) => c.id.toString() === param.farmId));
    console.log(farms)
    runScript();
    console.log(2);
  },[farms]);

  console.log(farm)

  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="#">
                <strong>
                  <span className="mdi mdi-home"></span> Home
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Campaign</a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">{farm && farm.name}</a>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-single section-padding pt-3">
        <div className="container">
          <div className="row">
            <div className="col-md-4">
              <FarmPicture/>
              <FarmDetail farm = {{...farm}}/>
            </div>
            <div className="col-md-8">
              
              {/* <ListFarms campaignId={param.id} /> */}
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Farm;
