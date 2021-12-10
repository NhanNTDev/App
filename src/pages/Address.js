import AccountLeft from "../components/AccountLeft";
import AddressForm from "../components/AddressForm";

const Address = () => {
  return (
    <section className="account-page section-padding">
      <div className="container">
        <div className="row">
          <div className="col-lg-9 mx-auto">
            <div className="row no-gutters">
              <div className="col-md-4">
                <AccountLeft/>
              </div>
              <div className="col-md-8">
                <AddressForm/>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Address;
