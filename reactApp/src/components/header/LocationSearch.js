import PlacesAutocomplete from "react-places-autocomplete";
import axios from "axios";
import { useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import { setLocation } from "../../state_manager_redux/location/locationSlice";

const LocationSearch = () => {
  const [address, setAddress] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const [gmapsLoaded, setGmapsLoaded] = useState(false);

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
  const offcanvas = () => {
    var element = document.getElementById("toggle");
    element.classList.toggle("toggled");
  };

  const handleLocationButtonClick = () => {
    var element = document.getElementById("toggle");
    element.classList.toggle("toggled");
  };

  const handleChange = (address) => {
    setAddress(address);
  };

  const handleSelect = (address) => {
    if (address === undefined || address.trim() === "") return;

    setAddress(address);
    const action = setLocation({ location: address });
    dispatch(action);
    setAddress("");
    offcanvas();
    navigate("/home");
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
    offcanvas();
    navigate("/home");
  };
  const searchOptions = {
    componentRestrictions: { country: ["vn"] },
    types: ["address"],
  };
  return (
    <>
      <div id="toggle">
        <div className="location-search-slider">
          <div className="location-search-slider-header">
            <a
              onClick={handleLocationButtonClick}
              className="float-right"
              id="off-location-search-slider"
            >
              <i className="mdi mdi-close"></i>
            </a>
          </div>
          <div className="location-search-slider-body">
            <div style={{ marginLeft: 50 }}>
              {gmapsLoaded && (
                <PlacesAutocomplete
                  value={address}
                  onChange={handleChange}
                  onSelect={handleSelect}
                  searchOptions={searchOptions}
                  debounce={500}
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
              )}
              <br />
              <strong className="d-flex justify-content-center">Hoặc</strong>
              <br />
              <button className="form-control locate-btn" onClick={getLocation}>
                <i className="mdi mdi-crosshairs-gps"></i> Lấy vị trí hiện tại
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default LocationSearch;
