import 'dart:developer';

import 'package:aws_covid_care/screens/article_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Map",
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: "https://goofy-sinoussi-bc227f.netlify.app/",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
