import React from "react";
import logo from "./logo.svg";
import { Counter } from "./features/counter/Counter";
import "./App.css";
import "./css/osahan.css";
import "./css/osahan2.css";
import Home from "./pages/Home";
import Index from "./pages/Index";
class App extends React.Component {
  render() {
    return (
      <div>
        <Index></Index>
      </div>
      
    );
  }
}

export default App;
