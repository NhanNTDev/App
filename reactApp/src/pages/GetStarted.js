const GetStarted = () => {
  return (
    <>
      <div className="container" style={{ display: "flex", height: "500px" }}>
        <div style={{ flex: 3 }}>
          <h1>Chưa có địa chỉ nè mấy đứa</h1>
        </div>
        <div
          style={{
            flex: 2,
            border: "1px solid",
            backgroundImage: "/img/vegetable.jpg",
            backgroundSize: "cover",
            backgroundPosition: "center",
          }}
        ></div>
      </div>
    </>
  );
};

export default GetStarted;
