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
        // Making a varibale in the Shared preferences.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int count = prefs.getInt(AppConstants.locationDected) ?? 0; // Setting it null, if it is a first try.
        count++; // Incrementing the count by one.
        // Setting the values in the Shared Preferences.
        prefs.setInt(AppConstants.locationDected, count);

        // Detecting the location.
        Position _fetchedUserLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        // After collection of Data send it to the flutter_local_notifications. (Both Position Object & count are passed up to show them.)
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
  bool _tracing = false;

  @override
  void initState() {
    super.initState();
  }

  void _startBackgroundLocationTracker() async {
    Geolocator _geolocator = Geolocator();
    await _geolocator.checkGeolocationPermissionStatus();
    await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    GeolocationStatus _geoStatus = await _geolocator.checkGeolocationPermissionStatus();
    log("GEOSTATUS VALUE" + _geoStatus.value.toString());
    if (_geoStatus.value == 2) {
      log("Location Allowed!");
      setState(() {
        _tracing = true;
      });
      Workmanager.initialize(callbackDispatcher, isInDebugMode: false);
      Workmanager.registerPeriodicTask("1", fetchBackground, frequency: Duration(minutes: 15));
    } else {
      Widget alert = AlertDialog(
        title: Text("Allow location"),
        content: Text("We don't spy 🍻"),
        actions: [FlatButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
      );
      showDialog(context: context, builder: (_) => alert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await Workmanager.cancelByTag(fetchBackground).then((value) => _authentication.handleSignOut());
              }),
          Text("Logout")
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tracing
                ? Text(
                    'You will be get notified within 15 min/more with counts',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  )
                : SizedBox(),
            RaisedButton(
                onPressed: () async {
                  _startBackgroundLocationTracker();
                },
                elevation: 10.0,
                color: _tracing ? Colors.green : Colors.blueAccent,
                child: Text(
                  _tracing ? "STARTED" : "Start Background Geolocation",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
