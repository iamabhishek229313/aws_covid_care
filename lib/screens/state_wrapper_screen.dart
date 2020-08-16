import 'package:aws_covid_care/screens/login_screen.dart';
import 'package:aws_covid_care/screens/register_screen.dart';
import 'package:flutter/material.dart';

class StateWrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     color: Colors.amber,
    //     child: Center(
    //       child: Text(
    //         "Open Sans looks good right?",
    //         style: TextStyle(fontSize: 28.0),
    //       ),
    //     ),
    //   ),
    // );

    return Login();
  }
}
