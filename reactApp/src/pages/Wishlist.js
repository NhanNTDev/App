import AccountLeft from "../components/AccountLeft"
import WistlistTable from "../components/WistlistTable";

const Wishlist = () => {
  return (
    <section class="account-page section-padding">
      <div class="container">
        <div class="row">
          <div class="col-lg-9 mx-auto">
            <div class="row no-gutters">
              <div class="col-md-4">
                  <AccountLeft/>
              </div>

              <div class="col-md-8">
                  <WistlistTable/>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Wishlist;
