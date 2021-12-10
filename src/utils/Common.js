export const runScript = () => {
  var head = document.getElementsByTagName("head")[0];
  var script = document.createElement("script");
  script.src = "vendor/owl-carousel/owl.carousel.js";
  var script1 = document.createElement("script");
  script1.src = "js/custom.js";
  console.log(script);

  head.appendChild(script);
  head.appendChild(script1);
};
