import Footer from "../components/home/Footer";
import Header from "../components/header/Header";
import AppRouter from "../router/AppRouter";

const WelcomePage = () => {
  return (
    <div style={{ backgroundColor: "#f9f9f9" }}>
      <Header/>
      <AppRouter/>
      <Footer/>
      </div>
  );
};

export default WelcomePage;