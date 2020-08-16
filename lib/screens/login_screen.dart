import 'dart:developer';

import 'package:aws_covid_care/screens/register_screen.dart';
import 'package:aws_covid_care/services/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Authentication _authentication = Authentication();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight - MediaQuery.of(context).padding.top,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48.0),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Fill some details below',
                    style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? "Enter a valid Email Address" : null,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.mail_outline,
                          color: Colors.black12,
                        ),
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Email address'),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? "Enter your password" : null,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black12,
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  SizedBox(
                    width: screenWidth,
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // Will do something.
                          log("Email add = " + _emailController.text);
                          log("Pass  = " + _passwordController.text);
                          FirebaseUser _user;
                          try {
                            _user = await _authentication.handleSignInEmail(
                                _emailController.text, _passwordController.text);
                          } catch (e) {
                            Widget alert = AlertDialog(
                              title: Text("Error ceredentials"),
                              content:
                                  Text("User doesn't exists or password is incorrect. Try creating a new account."),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("TRY AGAIN"),
                                )
                              ],
                            );
                            showDialog(context: context, builder: (_) => alert);
                            log(e.toString());
                          }
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                      color: Colors.lightBlueAccent,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                      elevation: 6,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Not an existing user?,'),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => Register()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
