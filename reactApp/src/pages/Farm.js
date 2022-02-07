import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import farmApi from "../apis/farmApi";
import FarmDetail from "../components/farm/FarmDetail";
import FarmPicture from "../components/farm/FarmPicture";
import ProductList from "../components/product/ProductList";
import {
  page1_farm,
} from "../constants/Data";
import { deleteScript, runScript } from "../utils/Common";

const Farm = () => {
  const param = useParams();
  const [page, setPage] = useState(1);
  const [farm, setFarm] = useState({});
  const [farms, setFarms] = useState([]);

  useEffect(() => {
    const fetchFarms = async () => {
      const params = {
        page: page,
        size: 12
      }
      const farmsResponse = await farmApi.getAll(params);      
    setFarms(farmsResponse.data);
    }
    fetchFarms();
    deleteScript();
  }, []);

  useEffect(() => {
    setFarm(farms.find((c) => c.id.toString() === param.farmId));
    runScript();
  },[farms]);


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
              <FarmPicture farm={{...farm}}/>
              <FarmDetail farm = {{...farm}}/>
            </div>
            <div className="col-md-8">
              <ProductList campaignId={param.campaignId} farmId={param.farmId}/>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Farm;
