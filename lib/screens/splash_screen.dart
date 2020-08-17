import 'dart:async';
import 'dart:developer';

import 'package:aws_covid_care/screens/home_screen.dart';
import 'package:aws_covid_care/screens/onboarding_screen.dart';
import 'package:aws_covid_care/screens/state_wrapper_screen.dart';
import 'package:aws_covid_care/utils/const_colors.dart';
import 'package:aws_covid_care/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

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
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                    colors: [Colors.black87, Colors.indigo.shade900, Colors.indigo.shade800, Colors.black87],
                    stops: [0.0, 8.0, 6.0, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Image.asset(
                      'assets/images/vector.png',
                      color: kPrimaryblack,
                    ),
                  ),
                ),
                Align(
                    child: Text(
                  "<COVID CARE/>",
                  style: TextStyle(fontSize: 42.0, color: Colors.white),
                )),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: Image.asset(
                      'assets/images/vector2.png',
                      color: kPrimaryblack,
                    ),
                  ),
                ),
                // Image
                // Container(
                //   constraints: BoxConstraints.expand(),
                //   color: Colors.blueGrey,
                //   child: Center(
                //     child: Text(
                //       "Hello!",
                //       style: TextStyle(fontSize: 45.0),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    @override
    Path getClip(Size size) {
      Path path = Path();
      final double _xScaling = size.width / 414;
      final double _yScaling = size.height / 896;
      path.lineTo(-85.8912 * _xScaling, 289.388 * _yScaling);
      path.cubicTo(
        -34.0201 * _xScaling,
        277.413 * _yScaling,
        11.0669 * _xScaling,
        238.676 * _yScaling,
        66.5766 * _xScaling,
        249.544 * _yScaling,
      );
      path.cubicTo(
        122.119 * _xScaling,
        260.418 * _yScaling,
        168.648 * _xScaling,
        312.375 * _yScaling,
        218.439 * _xScaling,
        348.97 * _yScaling,
      );
      path.cubicTo(
        267.351 * _xScaling,
        384.919 * _yScaling,
        324.885 * _xScaling,
        410.894 * _yScaling,
        358.91 * _xScaling,
        464.401 * _yScaling,
      );
      path.cubicTo(
        392.814 * _xScaling,
        517.716 * _yScaling,
        393.723 * _xScaling,
        582.808 * _yScaling,
        405.784 * _xScaling,
        643.579 * _yScaling,
      );
      path.cubicTo(
        417.205 * _xScaling,
        701.128 * _yScaling,
        430.011 * _xScaling,
        758.078 * _yScaling,
        428.401 * _xScaling,
        814.544 * _yScaling,
      );
      path.cubicTo(
        426.713 * _xScaling,
        873.733 * _yScaling,
        424.117 * _xScaling,
        935.854 * _yScaling,
        396.149 * _xScaling,
        981.472 * _yScaling,
      );
      path.cubicTo(
        368.2 * _xScaling,
        1027.06 * _yScaling,
        314.161 * _xScaling,
        1040.22 * _yScaling,
        272.099 * _xScaling,
        1069.49 * _yScaling,
      );
      path.cubicTo(
        227.569 * _xScaling,
        1100.47 * _yScaling,
        195.369 * _xScaling,
        1159.46 * _yScaling,
        139.219 * _xScaling,
        1160.24 * _yScaling,
      );
      path.cubicTo(
        82.9956 * _xScaling,
        1161.02 * _yScaling,
        31.44 * _xScaling,
        1104.24 * _yScaling,
        -22.6558 * _xScaling,
        1073.57 * _yScaling,
      );
      path.cubicTo(
        -72.2668 * _xScaling,
        1045.45 * _yScaling,
        -122.625 * _xScaling,
        1022.77 * _yScaling,
        -168.39 * _xScaling,
        985.865 * _yScaling,
      );
      path.cubicTo(
        -217.948 * _xScaling,
        945.903 * _yScaling,
        -275.289 * _xScaling,
        908.069 * _yScaling,
        -302.481 * _xScaling,
        847.928 * _yScaling,
      );
      path.cubicTo(
        -329.673 * _xScaling,
        787.785 * _yScaling,
        -312.924 * _xScaling,
        723.222 * _yScaling,
        -315.664 * _xScaling,
        660.137 * _yScaling,
      );
      path.cubicTo(
        -318.316 * _xScaling,
        599.081 * _yScaling,
        -330.1 * _xScaling,
        536.794 * _yScaling,
        -318.471 * _xScaling,
        479.749 * _yScaling,
      );
      path.cubicTo(
        -306.26 * _xScaling,
        419.851 * _yScaling,
        -289.302 * _xScaling,
        356.733 * _yScaling,
        -246.707 * _xScaling,
        321.87 * _yScaling,
      );
      path.cubicTo(
        -204.252 * _xScaling,
        287.122 * _yScaling,
        -139.631 * _xScaling,
        301.795 * _yScaling,
        -85.8912 * _xScaling,
        289.388 * _yScaling,
      );
      path.cubicTo(
        -85.8912 * _xScaling,
        289.388 * _yScaling,
        -85.8912 * _xScaling,
        289.388 * _yScaling,
        -85.8912 * _xScaling,
        289.388 * _yScaling,
      );
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
