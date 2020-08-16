import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Center(
                    child: Text(
                      'Fill your details below',
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
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail_outline,
                        color: Colors.black12,
                      ),
                      labelText: 'Fullname',
                      labelStyle: TextStyle(color: Colors.orange),
                      border: InputBorder.none,
                      hintText: 'Enter your fullname....'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12, width: 2)),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
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
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.call,
                        color: Colors.black12,
                      ),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.orange),
                      border: InputBorder.none,
                      hintText: 'Enter your phone number....'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12, width: 2)),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.assistant,
                        color: Colors.black12,
                      ),
                      labelText: 'Referal Code',
                      labelStyle: TextStyle(color: Colors.orange),
                      border: InputBorder.none,
                      hintText: 'Enter your referal code....'),
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
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    elevation: 6,
                  )),
              Divider(
                color: Colors.black12,
                indent: 50,
                endIndent: 50,
                thickness: 3,
              ),
              Text(
                'Sign Up via other accounts',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              'ƒ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        )),
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: RaisedButton(
                          color: Colors.red,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              'G+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        )),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              't',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
