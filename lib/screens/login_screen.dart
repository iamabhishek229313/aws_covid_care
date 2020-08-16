import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Center(
                child: Text(
                  'login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Center(
                    child: Text(
                      'Fill some details below',
                      style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12, width: 2)),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail_outline,
                        color: Colors.black12,
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.orange),
                      border: InputBorder.none,
                      hintText: 'Enter your email....'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12, width: 2)),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black12,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.orange),
                      border: InputBorder.none,
                      hintText: 'Enter your Password....'),
                ),
              ),
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    elevation: 6,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Not an existing user?,'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: Border.all(color: Colors.black12)),
            height: 230,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black26)),
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black54)),
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Icon(
                  Icons.mail_outline,
                  size: 100,
                  color: Colors.orange[300],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
