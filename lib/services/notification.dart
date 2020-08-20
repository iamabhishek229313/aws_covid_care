import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class Notification {
  // In class global un-declared object.
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Constructor
  Notification() {
    log("Notification constructor is invoked!");
    var _initializationSetingAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var _initializationSettingIOS = new IOSInitializationSettings();

    var _initializationSetting = new InitializationSettings(_initializationSetingAndroid, _initializationSettingIOS);

    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(_initializationSetting);
    log(_flutterLocalNotificationsPlugin.toString());
  }

  Future showNotificationWithoutSound(Position pos, int count) async {
    log(pos.toString());
    var _androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'location-bg', "fetched Background location",
        playSound: false, importance: Importance.Max, priority: Priority.High);

    var _iosPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: false);

    var _platformChannelSpecifics =
        new NotificationDetails(_androidPlatformChannelSpecifics, _iosPlatformChannelSpecifics);

    try {
      await _flutterLocalNotificationsPlugin.show(
          0, 'Location fetched', pos.toString() + " " + "Count is = " + count.toString(), _platformChannelSpecifics,
          payload: '');
    } catch (e) {
      log("Exception catched!");
      print(e);
    }

    log("Finished Notification");
  }
}
