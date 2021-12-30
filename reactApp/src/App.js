import React from "react";
import { Counter } from "./features/counter/Counter";
import WelcomePage from "./pages/WelcomePage";
import Account from "./pages/Account";
class App extends React.Component {
  render() {
    return (
      <>
        <WelcomePage></WelcomePage>
      </>

    );
  }
}

export default App;
