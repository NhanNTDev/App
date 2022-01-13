const PageNotFound = () => {
  return (
    <>
      <section className="not-found-page section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-8 mx-auto text-center  pt-4 pb-5">
              <h1>
                <img className="img-fluid" src="/img/404.png" alt="404" />
              </h1>
              <h1>Xin lỗi! Chúng tôi không tìm thấy trang!</h1>
              <p className="land">
                Có thể trang bạn đang tìm kiếm đã được di chuyển hoặc bị xóa!
              </p>
              <div className="mt-5">
                <a href="/home" className="btn btn-success btn-lg">
                  <i className="mdi mdi-home"></i> TRỞ VỀ TRANG CHỦ
                </a>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default PageNotFound;
