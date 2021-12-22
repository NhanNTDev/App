export const runScript = () => {
  var body = document.getElementsByTagName("body")[0];
  var script = document.createElement("script");
  script.src = "vendor/owl-carousel/owl.carousel.js";
  script.id = "vendor_carousel";
  script.type = "text/javascript";
  var script1 = document.createElement("script");
  script1.src = "js/custom.js";
  script1.id = "custom";
  script1.type = "text/javascript";
  console.log("RunScrip");
  body.appendChild(script);
  body.appendChild(script1);
};

export const deleteScript = () => {
  var script = document.getElementById("vendor_carousel")
  var script1 = document.getElementById("custom")
  console.log("DeleteScrip")
  if(script !== null)
  {
    script.remove()
  }
  
  if(script1 !== null)
  {
    script1.remove()
  }
};
