import ChangePasswordForm from "../components/account/ChangePasswordForm";
import MenuAccountLeft from "../components/account/MenuAccountLeft";

const ChangePassword = () => {

    return (
      <section className="account-page section-padding">
          <div className="container">
            <div className="row">
              <div className="col-lg-6 mx-auto">
                <div className="row no-gutters">
                  <div className="col-md-6">
                    <MenuAccountLeft type="changePassword"/>
                  </div>
                  <div className="col-md-6">
                    <ChangePasswordForm/>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
    );
  };
  
  export default ChangePassword;