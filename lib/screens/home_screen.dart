import 'package:aws_covid_care/services/firebase_authentication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authentication.handleSignOut();
              })
        ],
      ),
      body: Center(
        child: Text(
          "HOMESCREEN",
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
