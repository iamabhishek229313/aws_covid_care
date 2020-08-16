import 'dart:developer';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48.0),
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
                controller: _passController,
                autovalidate: _autoValidate,
                validator: (value) => value.isEmpty ? "Enter a password" : null,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail_outline,
                      color: Colors.black12,
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Email address'),
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
                      Icons.lock,
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
                  onPressed: () {
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
                          actions: [FlatButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
                        );
                        showDialog(context: context, builder: (_) => alert);
                      } else {
                        // Will talk to backend.
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
              Divider(
                color: Colors.black12,
                thickness: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
