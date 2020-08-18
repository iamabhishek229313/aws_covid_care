import 'dart:developer';
import 'dart:math' as math;

import 'package:aws_covid_care/models/user.dart';
import 'package:aws_covid_care/services/notification.dart' as notif;

import 'package:aws_covid_care/services/firebase_authentication.dart';
import 'package:aws_covid_care/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Firestore _firestore = Firestore.instance;
  User _userDetails;
  bool _tracing = false;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> _loadingCredentials() async {
    log("_loading...");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userID = _prefs.getString(AppConstants.userId);
    log("USER ID " + userID);
    await _firestore.collection("users").document(userID).get().then((value) {
      _userDetails = User.fromJson(value.data);
      log(_userDetails.toJson().toString());
    });
    return _userDetails;
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _loadingCredentials(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData)
          return Container(
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: Icon(Icons.location_on),
          // ),
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Image.asset(
                        'assets/icons/mask_person.png',
                        width: 50.0,
                        height: 60.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    accountName: Text(
                      _userDetails.displayName.toUpperCase(),
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                    ),
                    accountEmail: Text(_userDetails.email)),
                ListTile(
                  onTap: () async {
                    await Workmanager.cancelByTag(fetchBackground).then((value) => _authentication.handleSignOut());
                  },
                  title: Text("Logout"),
                  trailing: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Home screen"),
            centerTitle: true,
            elevation: 10.0,
            actions: [
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  }),
              IconButton(
                  icon: Icon(_tracing ? Icons.location_on : Icons.location_off),
                  onPressed: () {
                    setState(() {});
                  }),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.22,
                  width: double.maxFinite,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(milliseconds: 2400),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enlargeCenterPage: true),
                    items: List.generate(
                        9,
                        (index) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.primaries[math.Random().nextInt(18)],
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.lightGreenAccent,
                  height: screenHeight * 0.18,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      children: List.generate(9, (index) {
                        return Material(
                          elevation: 8.0,
                          shadowColor: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.all(screenHeight * 0.02),
                            height: screenHeight * 0.09,
                            width: screenHeight * 0.09,
                            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              color: Colors.primaries[math.Random().nextInt(18)],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Previous body.

// body: Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       _tracing
//           ? Text(
//               'You will be get notified within 15 min/more with counts',
//               style: TextStyle(fontSize: 14.0, color: Colors.black),
//             )
//           : SizedBox(),
//       RaisedButton(
//           onPressed: () async {
//             _startBackgroundLocationTracker();
//           },
//           elevation: 10.0,
//           color: _tracing ? Colors.green : Colors.blueAccent,
//           child: Text(
//             _tracing ? "STARTED" : "Start Background Geolocation",
//             style: TextStyle(fontSize: 18.0, color: Colors.white),
//           ))
//     ],
//   ),
// ),
