import 'package:flutter/material.dart';

class StateWrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Text(
            "Open Sans looks good right?",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
      ),
    );
  }
}
