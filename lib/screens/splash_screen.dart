import 'dart:async';
import 'dart:developer';

import 'package:aws_covid_care/screens/home_screen.dart';
import 'package:aws_covid_care/screens/onboarding_screen.dart';
import 'package:aws_covid_care/screens/state_wrapper_screen.dart';
import 'package:aws_covid_care/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// After checking whether a User is using the app first time or not we will determine what to show->
// 1) User comes first time: Show them Onboarding screens.
// 2) Otherwise: Show Authentication Screen or HomeScreen (Based on Firebase Current user).
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  _jumpToScreen(bool isfirstTime) {
    log("Is first time? " + (!isfirstTime).toString());
    Timer(
        Duration(milliseconds: 1800),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => !isfirstTime ? OnboardingScreen() : StateWrapperScreen())));
  }

  Future<dynamic> _fetchFirstTimeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool(AppConstants.firstUser) ?? false;
    return _jumpToScreen(isFirstTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchFirstTimeState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // Wether we have data or not? Ans: We don't care it's not an API call.
          return Container(
            constraints: BoxConstraints.expand(),
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                "Hello!",
                style: TextStyle(fontSize: 45.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
