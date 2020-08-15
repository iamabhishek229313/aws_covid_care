import 'dart:math';

import 'package:aws_covid_care/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController;
  bool _showFAB;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _showFAB = false;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: _showFAB
          ? FloatingActionButton.extended(
              onPressed: () async {
                // Below code will a make boolean value in the device memory saying user have
                // gone through the onboard screens.
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(AppConstants.firstUser, true).then((value) {
                  print("Saved Preference as a value of = " + value.toString());
                });
              },
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              label: Text(
                "Got it",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.8,
                child: PageView(
                  controller: _pageController,
                  children: List.generate(
                      6,
                      (_) => Container(
                            color: Colors.primaries[Random().nextInt(12)],
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            child: Container(height: 280),
                          )),
                  onPageChanged: (int _pageIndex) {
                    if (_pageIndex == 5) {
                      setState(() {
                        _showFAB = true;
                      });
                    } else
                      setState(() {
                        _showFAB = false;
                      });
                  },
                ),
              ),
              SizedBox(height: 32.0),
              Container(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 6,
                  effect: WormEffect(activeDotColor: Colors.blueAccent, dotColor: Colors.blue.shade50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
