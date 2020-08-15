import 'dart:async';

import 'package:aws_covid_care/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1200), () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
