import 'dart:developer';

import 'package:aws_covid_care/services/notification.dart' as notif;

import 'package:aws_covid_care/services/firebase_authentication.dart';
import 'package:aws_covid_care/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    switch (taskName) {
      case fetchBackground:
        log("Callback Dispatcher with Service  = " + fetchBackground + " is initialized");
        Geolocator _geolocator = Geolocator();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int count = prefs.getInt(AppConstants.locationDected) ?? 0;
        count++;
        prefs.setInt(AppConstants.locationDected, count);
        // GeolocationStatus _geoLocationStatus = await _geolocator.checkGeolocationPermissionStatus();
        Position _fetchedUserLocation = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        notif.Notification _notif = new notif.Notification();
        _notif.showNotificationWithoutSound(_fetchedUserLocation, count);
        break;
    }
    return Future.value(true);
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Authentication _authentication = Authentication();
  SharedPreferences prefs;
  Position _position;

  @override
  void initState() {
    super.initState();
  }

  void _geoLocation() async {
    log("There");
    Geolocator _geolocator = Geolocator();
    prefs = await SharedPreferences.getInstance();
    GeolocationStatus _geoLocationStatus = await _geolocator.checkGeolocationPermissionStatus();
    Position _userPosition = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      log("Wprked");
      _position = _userPosition;
    });
    log(_position.toString());
    // return _userPosition;
    Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager.registerPeriodicTask("1", fetchBackground, frequency: Duration(minutes: 15));
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (prefs != null)
                ? Text(
                    'How many times background service is maded = ' +
                        (prefs.getInt(AppConstants.locationDected) ?? 0).toString(),
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  )
                : SizedBox(),
            RaisedButton(
                onPressed: () {
                  _geoLocation();
                },
                elevation: 10.0,
                color: Colors.blueAccent,
                child: Text(
                  "Start Background Services",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
