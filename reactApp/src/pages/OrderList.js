import AccountLeft from "../components/AccountLeft";
import OrderTable from "../components/OrderTable";

const OrderList = () => {
  return (
    <section className="account-page section-padding">
      <div className="container">
        <div className="row">
          <div className="col-lg-9 mx-auto">
            <div className="row no-gutters">
              <div className="col-md-4">
                <AccountLeft />
              </div>
              <div className="col-md-8">
                <OrderTable />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default OrderList;
