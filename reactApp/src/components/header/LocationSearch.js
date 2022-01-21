import PlacesAutocomplete from "react-places-autocomplete";
import axios from "axios";
import { useState } from "react";

const LocationSearch = ({ callback }) => {
  const [address, setAddress] = useState();
  const offcanvas = () => {
    let offButton = document.getElementById("off-location-search-slider");
    offButton.click();
  };

  const handleChange = (address) => {
    setAddress(address);
  };

  const handleSelect = (address) => {
    setAddress(address);
    if (localStorage) {
      localStorage.setItem("dichonao_userAddress", address);
    }
    callback(address);
    setAddress("");
    offcanvas();
  };
  const getLocation = async () => {
    let location;
    if (navigator.geolocation) {
      location = navigator.geolocation.getCurrentPosition(
        getLocationSuccess,
        showError
      );
      console.log(location);
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
      process.env.REACT_APP_GEOLOCATION_API_KEY;
    const result = await axios(url);
    console.log(result);
    const address = result.data.results[0].formatted_address;
    console.log(address);
    setAddress(address);
    if (localStorage) {
      localStorage.setItem("dichonao_userAddress", address);
    }
    callback(address);
    setAddress("");
    offcanvas();
  };

  return (
    <>
      <div className="location-search-slider">
        <div className="location-search-slider-header">
          <a
            data-toggle="offcanvas"
            className="float-right"
            id="off-location-search-slider"
          >
            <i className="mdi mdi-close"></i>
          </a>
        </div>
        <div className="location-search-slider-body">
          <div style={{ marginLeft: 50 }}>
            <PlacesAutocomplete
              value={address}
              onChange={handleChange}
              onSelect={handleSelect}
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
            <br />
            <strong className="d-flex justify-content-center">Hoặc</strong>
            <br />
            <button className="form-control locate-btn" onClick={getLocation}>
              <i className="mdi mdi-crosshairs-gps"></i> Lấy vị trí hiện tại
            </button>
          </div>
        </div>
      </div>
    </>
  );
};

export default LocationSearch;
