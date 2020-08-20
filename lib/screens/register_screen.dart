import 'dart:developer';

import 'package:aws_covid_care/models/user.dart';
import 'package:aws_covid_care/services/firebase_authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aws_covid_care/utils/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Authentication _authentication = Authentication();
  Firestore _firestore = Firestore.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade50],
                      stops: [0.0, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Center(
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: screenWidth * 0.9,
                    // height: screenHeight * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Sign Up',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 48.0),
                            ),
                            Text(
                              'Fill your details below',
                              style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            SizedBox(
                              height: 32.0,
                            ),
                            TextFormField(
                              controller: _fullNameController,
                              autovalidate: _autoValidate,
                              validator: (value) => value.isEmpty ? "Enter you name" : null,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person_add,
                                    color: Colors.black12,
                                  ),
                                  labelText: 'Name',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  hintText: 'Full Name'),
                            ),
                            SizedBox(
                              height: 16.0,
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
                              controller: _phoneNumberController,
                              autovalidate: _autoValidate,
                              keyboardType: TextInputType.number,
                              validator: (value) => value.isEmpty ? "Enter a phone number" : null,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.dialpad,
                                    color: Colors.black12,
                                  ),
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  hintText: 'Phone Number'),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: _passController,
                              autovalidate: _autoValidate,
                              validator: (value) => value.isEmpty ? "Enter a password" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black12,
                                  ),
                                  labelText: 'Password',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  hintText: 'Password'),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: _confirmPassController,
                              autovalidate: _autoValidate,
                              validator: (value) => value.isEmpty ? "Please confirm password" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black12,
                                  ),
                                  labelText: 'Confirm Password',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  hintText: 'Confirm Password'),
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
                                    log("Full Name add = " + _fullNameController.text);
                                    log("Email  = " + _emailController.text);
                                    log("Pass  = " + _passController.text);
                                    log("Confirm Pass  = " + _confirmPassController.text);
                                    if (_passController.text != _confirmPassController.text) {
                                      log("Didn't match");
                                      Widget alert = AlertDialog(
                                        content: Text("Confim Password didn't match! Please try again"),
                                        actions: [
                                          FlatButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
                                        ],
                                      );
                                      showDialog(context: context, builder: (context) => alert);
                                    } else {
                                      // Will talk to backend.
                                      FirebaseUser _user;
                                      try {
                                        _user = await _authentication.handleSignUp(
                                            _emailController.text, _passController.text);
                                      } catch (e) {
                                        Widget alert = AlertDialog(
                                          title: Text("Error creating new user!"),
                                          content: Text(
                                              "User may exists in database. Try creating a with other e-mail address."),
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

                                      if (_user != null) {
                                        Coords coord = Coords("XXX XXXXX", "XXXX XXXX");
                                        User _userDetils = User(_fullNameController.text, _emailController.text,
                                            _phoneNumberController.text, coord);
                                        await _firestore
                                            .collection("users")
                                            .document("${_user.uid}")
                                            .setData(_userDetils.toJson())
                                            .then((value) async {
                                          log("Updated the data in the fireStore.");
                                          Navigator.pop(context);
                                        });
                                      }
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
                                  'SIGN UP',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
                                ),
                                elevation: 6,
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top + 10.0,
                left: 16.0,
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context)),
                )),
          ],
        ),
      ),
    );
  }
}
