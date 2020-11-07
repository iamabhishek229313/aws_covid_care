import 'dart:io' as io;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom scroll behaviour to remove the [TargetPlatform.android] glow
/// and [TargetPlatform.iOS] bounce
class CustomScrollBehaviour implements ScrollBehavior {
  const CustomScrollBehaviour();

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  TargetPlatform getPlatform(BuildContext context) {
    if (io.Platform.isIOS) return TargetPlatform.iOS;
    return TargetPlatform.android;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  bool shouldNotify(ScrollBehavior oldDelegate) {
    return false;
  }

  @override
  velocityTrackerBuilder(BuildContext context) {
    // TODO: implement velocityTrackerBuilder
    return (event) {};
  }
}
