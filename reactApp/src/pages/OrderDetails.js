import MenuAccountLeft from "../components/account/MenuAccountLeft";
import OrderDetailsTable from "../components/account/OrderDetailsTable";
import OrderTable from "../components/account/OrderTable";

const OrderDetails = () => {
  return (
    <section className="account-page section-padding">
      <div className="container">
        <div className="row">
          <div className="col-lg-12 mx-auto">
            <div className="row no-gutters">
              <div className="col-md-2">
                <MenuAccountLeft type="orderList"/>
              </div>
              <div className="col-md-10">
                <OrderDetailsTable />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default OrderDetails;
