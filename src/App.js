import React from "react";
import logo from "./logo.svg";
import { Counter } from "./features/counter/Counter";
import Home from "./pages/Home";
import Checkout from "./pages/Checkout";
class App extends React.Component {
  render() {
    return (
      <>
        <Checkout></Checkout>
      </>

    );
  }
}

export default App;
