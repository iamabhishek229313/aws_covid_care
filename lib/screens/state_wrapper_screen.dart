import 'dart:developer';

import 'package:aws_covid_care/screens/home_screen.dart';
import 'package:aws_covid_care/screens/login_screen.dart';
import 'package:aws_covid_care/screens/register_screen.dart';
import 'package:aws_covid_care/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateWrapperScreen extends StatelessWidget {
  // _registerUser(FirebaseUser user) async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   _prefs.setString(AppConstants.userId, user.uid);
  //   log("REgsitreeed");
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          log("Sanpshot data = " + snapshot.data.toString());

          if (!snapshot.hasData) return Login();
          return HomeScreen();
        });
  }
}
