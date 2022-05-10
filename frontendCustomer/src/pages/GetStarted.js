import React, { useEffect } from "react";
import PlacesAutocomplete from "react-places-autocomplete";
import axios from "axios";
import { useSelector } from "react-redux";
import { Link } from "react-router-dom";
import { useState } from "react";
import { useDispatch } from "react-redux";
import { setLocation } from "../state_manager_redux/location/locationSlice";

const GetStarted = () => {
  const [address, setAddress] = useState("");
  const dispatch = useDispatch();
  const [gmapsLoaded, setGmapsLoaded] = useState(false);
  const user = useSelector((state) => state.user);
  useEffect(() => {
    window.initMap = () => setGmapsLoaded(true);
    const currentGmap = document.getElementById("gmapScriptEl");
    if (currentGmap === null) {
      const gmapScriptEl = document.createElement(`script`);
      gmapScriptEl.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.REACT_APP_GOOGLE_MAP_API_KEY}&libraries=places&callback=initMap`;
      gmapScriptEl.id = "gmapScriptEl";
      document
        .querySelector(`body`)
        .insertAdjacentElement(`beforeend`, gmapScriptEl);
    } else {
      setGmapsLoaded(true);
    }
  }, []);

  const handleChange = (address) => {
    setAddress(address);
  };

  const handleSelect = (address) => {
    setAddress(address);
    const action = setLocation({ location: address });
    dispatch(action);
    setAddress("");
  };
  const handleFindButtonClick = () => {
    const action = setLocation({ location: address });
    dispatch(action);
    setAddress("");
  };
  const getLocation = async () => {
    let location;
    if (navigator.geolocation) {
      location = navigator.geolocation.getCurrentPosition(
        getLocationSuccess,
        showError
      );
    }
  };
  const getLocationSuccess = (position) => {
    getAddress(position);
  };

  const showError = (error) => {
    return error;
  };

  const getAddress = async (position) => {
    var url =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=" +
      position.coords.latitude +
      "," +
      position.coords.longitude +
      "&sensor=true" +
      "&key=" +
      process.env.REACT_APP_GOOGLE_MAP_API_KEY;
    const result = await axios(url);
    const address = result.data.results[0].formatted_address;
    setAddress(address);
    const action = setLocation({ location: address });
    dispatch(action);
    setAddress("");
  };
  const searchOptions = {
    componentRestrictions: { country: ["vn"] },
    types: ["address"],
  };
  return (
    <div className="container-fluid">
      <div className="get-started-page">
        <div className="form">
          <div className="row">
            <div className="col-sm">
              <h1 style={{ fontFamily: "arial", fontSize: "30px" }}>
                Đi Chợ Nào!
              </h1>
            </div>

            <div className="col-sm-3">
              {user === null ? (
                <span className="input-group-btn">
                  <Link to="/login">
                    <button className="btn btn-secondary" type="button">
                      Đăng nhập/Đăng ký
                    </button>
                  </Link>
                </span>
              ) : null}
            </div>
          </div>
          <div className="form-message">
            {user !== null ? (
              <>
                <h2>
                  Chào mừng <strong>{user.phoneNumber},</strong>
                </h2>
                <h5>Có vẻ như bạn chưa thiết lập địa chỉ</h5>
              </>
            ) : (
              <h2>Bạn ở đâu?</h2>
            )}
            <i>
              <h5>
                Hãy nhập địa chỉ để chúng tôi có thể xác định chính xác những
                chiến dịch phù hợp với bạn!
              </h5>
            </i>
          </div>
          <div className="row">
            <div className="col-sm-7">
              <form>
                <div className="form-group">
                  <div style={{ width: "100%" }}>
                    {gmapsLoaded && (
                      <PlacesAutocomplete
                        value={address}
                        onChange={handleChange}
                        onSelect={handleSelect}
                        searchOptions={searchOptions}
                      >
                        {({
                          getInputProps,
                          suggestions,
                          getSuggestionItemProps,
                          loading,
                        }) => (
                          <div>
                            <input
                              {...getInputProps({
                                placeholder: "Nhập địa chỉ",
                                className: "form-control",
                              })}
                              style={{ minWidth: 0 }}
                            />
                            <div className="autocomplete-dropdown-container">
                              {loading && <div>Đang tải...</div>}
                              {suggestions.map((suggestion) => {
                                const className = suggestion.active
                                  ? "suggestion-item--active"
                                  : "suggestion-item";
                                // inline style for demonstration purpose
                                const style = suggestion.active
                                  ? {
                                      backgroundColor: "#fafafa",
                                      cursor: "pointer",
                                    }
                                  : {
                                      backgroundColor: "#ffffff",
                                      cursor: "pointer",
                                    };
                                return (
                                  <div
                                    {...getSuggestionItemProps(suggestion, {
                                      className,
                                      style,
                                    })}
                                  >
                                    <span>{suggestion.description}</span>
                                  </div>
                                );
                              })}
                            </div>
                          </div>
                        )}
                      </PlacesAutocomplete>
                    )}
                  </div>
                </div>
              </form>
            </div>
            <div className="col-sm-5">
              <span className="input-group-btn">
                <button
                  className="btn btn-secondary-lighter"
                  onClick={getLocation}
                >
                  <span className="mdi mdi-target icons"> Định vị tôi</span>
                </button>
              </span>
              <span className="input-group-btn">
                <button
                  className="btn btn-secondary"
                  onClick={handleFindButtonClick}
                >
                  Tìm Sản Phẩm
                </button>
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default GetStarted;
