import React from "react";
import PlacesAutocomplete from "react-places-autocomplete";
import axios from "axios";
import { useSelector } from "react-redux";
import { Link } from "react-router-dom";
import { useState } from "react";
import { useDispatch } from "react-redux";
import { setLocation } from "../state_manager_redux/location/locationSlice";

const GetStarted = () => {
  const [address, setAddress] = useState();
  const dispatch = useDispatch();

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
  const user = useSelector((state) => state.user);
  const searchOptions = {
    componentRestrictions: { country: ['vn'] },
    types: ['address']
  }
  return (
    <div className="get-started-page">
      <div className="form">
        <div className="input-group" style={{ paddingBottom: 50 }}>
          <h1>Đi Chợ Nào</h1>
          {user === null ? (
            <li className="list-inline-item">
              <Link to="/login" className="btn btn-link">
                <i className="mdi mdi-account-circle"></i> Đăng nhập/Đăng ký
              </Link>
            </li>
          ) : null}
        </div>

        <div className="form-message">
          {user !== null ? (
            <h2>Chào mừng {user.shortName}</h2>
          ) : (
            <h2>Bạn ở đâu?</h2>
          )}
          <i>
            <h5>
              Hãy nhập địa chỉ để tìm kiếm những chiến dịch ưu đãi nhất ở gần
              bạn.
            </h5>
          </i>
        </div>

        <div className="input-group">
          <div style={{ width: "70%" }}>
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
                        ? { backgroundColor: "#fafafa", cursor: "pointer" }
                        : { backgroundColor: "#ffffff", cursor: "pointer" };
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
          </div>
          <span className="input-group-btn" style={{ maxWidth: "15%" }}>
            <button className="btn btn-secondary-lighter" onClick={getLocation}>
              <span className="mdi mdi-target icons"> Định vị tôi</span>
            </button>
          </span>
          <span className="input-group-btn" style={{ maxWidth: "15%" }}>
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
  );
};

export default GetStarted;
