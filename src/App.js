import React from "react";
import logo from "./logo.svg";
import { Counter } from "./features/counter/Counter";
import Home from "./pages/Home";
import Checkout from "./pages/Checkout"
import Account from "./pages/Account";
class App extends React.Component {
  render() {
    return (
      <>
        <Account></Account>
      </>

    );
  }
}

export default App;
