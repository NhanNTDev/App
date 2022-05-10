import MenuAccountLeft from "../components/account/MenuAccountLeft";
import ProfileForm from "../components/account/ProfileForm";


const Account = () => {
  return (
    <section className="account-page section-padding">
        <div className="container">
          <div className="row">
            <div className="col-lg-12 mx-auto">
              <div className="row no-gutters">
                <div className="col-md-4">
                  <MenuAccountLeft type="account"/>
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
