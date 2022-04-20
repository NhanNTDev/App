export const runScript = () => {
  var script = document.getElementById("vendor_carousel");
  var script1 = document.getElementById("custom");
  if (script !== null) {
    script.remove();
  }

  if (script1 !== null) {
    script1.remove();
  }
  var body = document.getElementsByTagName("body")[0];
  var script2 = document.createElement("script");
  script2.src = "/vendor/owl-carousel/owl.carousel.js";
  script2.id = "vendor_carousel";
  script2.type = "text/javascript";
  var script3 = document.createElement("script");
  script3.src = "/js/custom.js";
  script3.id = "custom";
  script3.type = "text/javascript";
  body.appendChild(script2);
  body.appendChild(script3);
};

// export const deleteScript = () => {};

export const parseTimeDMY = (datetime) => {
  const date = new Date(datetime);
  const formatedDate =
    date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
  return formatedDate;
};

export const parseTimeHMDMY = (datetime) => {
  const date = new Date(datetime);
  const formatedDate = date.getHours() + ":" + date.getMinutes() + " "+
    date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
  return formatedDate;
};
