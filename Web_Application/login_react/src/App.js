import React, {Component} from 'react';
import './App.css';
import Background from './images/background.jpg';

import { Button, Form, FormGroup, Label, Input, NavBar, Nav, NavItem, } from 'reactstrap';
import { FacebookLoginButton } from 'react-social-login-buttons';

function App() {
  return (

    <div className="login-form">
      <div className="background" style={{background: `url(${Background})`}}>
        <h6><br></br></h6>
        <div className="title">Library Management System</div>
        <br></br>
        <FormGroup>
          <Label>Username</Label>
          <Input type="username" placeholder="Username"/>
        </FormGroup>
        <FormGroup>
          <Label>Password</Label>
          <Input type="password" placeholder="Password"/>
        </FormGroup>
        <Button className="btn-dark btn-block">
          Log in
        </Button>
        <FormGroup>
        <br></br><br></br><br></br><br></br>
        </FormGroup>
        <div className="text1">
          Or continue with your social account
        </div>
        <FacebookLoginButton className="text1"/>
        <div className="text2">
          <a href="/sign-up">Sign up</a>
          <span className="text2">|</span>
          <a href="/forget-password">Forget password</a>
        </div>
        <h6><br></br></h6>
      </div>
    </div>

  );
}

export default App;
