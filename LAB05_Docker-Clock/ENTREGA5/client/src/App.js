import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Clock from './Clock'; // Custom Clock element
import socketIOClient from "socket.io-client";
import Clock2 from 'react-clock';
import 'bulma/css/bulma.css';

let time = new Date().toLocaleString();

class App extends Component {
  constructor() {
    super();
    this.state = {
      // sets initial state
      response: false,
      endpoint: "http://127.0.0.1:4001" //Server's address
    };
  }
  // called when component inserted in DOM
  componentDidMount() {
    const {endpoint} = this.state;
    // socket creation
    const socket = socketIOClient(endpoint);
    // on receiving date, store response
    socket.on("Date", data => this.setState({ response: data }));
  }


  render() {
    const { response } = this.state;
    console.log(response);
    // date formatting
    var cdate = (new Date(response));
    console.log(cdate);

    return (
      <div className="App">
      <section class="section">

        <div class="container">
          <div class="columns">

            <div class="column is-half">
              <div class="box">
                <h1 class="titulo">Local Time</h1>
                <div class="client">
                  <Clock></Clock>
                </div>
              </div>
            </div>

            <div class="column is-half">
              <div class="box">
                <h1 class="titulo">Server Time</h1>
                <div class="server">
                  <Clock2 value={cdate}/>
                  <p class="hora-dig" id="serverTime"> {cdate.toLocaleString()} </p>
                </div>
              </div>
            </div>

          </div>
        </div>

      </section>
      <footer class="footer">
        <div class="content has-text-centered">
          <p>
            <strong>Cloud-Clock</strong> by <a href="https://github.com/mariaventosa">Maria Ventosa</a>
          </p>
          <p class="footer-mini">Networks and Servers Administration LIS-4081 at UDLAP</p>
          <p class="footer-mini"> February 1st, 2019</p>
        </div>
      </footer>
    </div>

    );
  }
}

export default App;
