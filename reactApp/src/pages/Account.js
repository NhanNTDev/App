import AccountLeft from "../components/account/AccountLeft";
import ProfileForm from "../components/account/ProfileForm";


const Account = () => {
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
                  <ProfileForm/>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
  );
};

export default Account;
