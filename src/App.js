import React from "react";
import { Counter } from "./features/counter/Counter";
import Home from "./pages/Home";
import Checkout from "./pages/Checkout"
import Account from "./pages/Account";
import WelcomePage from "./pages/WelcomePage";
class App extends React.Component {
  render() {
    return (
      <>
        <Account></Account>
        <WelcomePage></WelcomePage>
      </>

    );
  }
}

export default App;
